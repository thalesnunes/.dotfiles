from __future__ import (absolute_import, division, print_function)

# You always need to import ranger.api.commands here to get the Command class:
from ranger.api.commands import Command


class paste_as_root(Command):
    def execute(self):
        if self.fm.do_cut:
            self.fm.execute_console("shell sudo mv %c .")
        else:
            self.fm.execute_console("shell sudo cp -r %c .")


class fzf_select(Command):
    """
    :fzf_select
    Find a file using fzf.
    With a prefix argument to select only directories.

    See: https://github.com/junegunn/fzf
    """

    def execute(self):
        import subprocess
        import os
        from ranger.ext.get_executables import get_executables

        if 'fzf' not in get_executables():
            self.fm.notify('Could not find fzf in the PATH.', bad=True)
            return

        fd = None
        if 'fdfind' in get_executables():
            fd = 'fdfind'
        elif 'fd' in get_executables():
            fd = 'fd'

        if fd is not None:
            hidden = ('--hidden' if self.fm.settings.show_hidden else '')
            exclude = "--no-ignore-vcs --exclude '.git' --exclude '*.py[co]' \
                    --exclude '__pycache__'"
            only_directories = ('--type directory' if self.quantifier else '')
            fzf_default_command = '{} --follow {} {} {} --color=always'.format(
                fd, hidden, exclude, only_directories
            )
        else:
            hidden = ('-false' if self.fm.settings.show_hidden
                      else r"-path '*/\.*' -prune")
            exclude = r"\( -name '\.git' -o -iname '\.*py[co]' \
                        -o -fstype 'dev' -o -fstype 'proc' \) -prune"
            only_directories = ('-type d' if self.quantifier else '')
            fzf_default_command = 'find -L . -mindepth 1 {} -o {} -o {} -print\
                        | cut -b3-'.format(
                hidden, exclude, only_directories
            )

        env = os.environ.copy()
        env['FZF_DEFAULT_COMMAND'] = fzf_default_command
        env['FZF_DEFAULT_OPTS'] = '--height=40% --layout=reverse --ansi \
                                    --preview="{}"'.format('''
            (
                batcat --color=always {} ||
                bat --color=always {} ||
                cat {} ||
                tree -ahpCL 3 -I '.git' -I '*.py[co]' -I '__pycache__' {}
            ) 2>/dev/null | head -n 100
        ''')

        fzf = self.fm.execute_command('fzf --no-multi', env=env,
                                      universal_newlines=True,
                                      stdout=subprocess.PIPE)
        stdout, _ = fzf.communicate()
        if fzf.returncode == 0:
            selected = os.path.abspath(stdout.strip())
            if os.path.isdir(selected):
                self.fm.cd(selected)
            else:
                self.fm.select_file(selected)


class add_mpv_playlist(Command):
    def execute(self):
        from pathlib import Path

        cache_file = Path('~/.cache/mpv/playlist_history').expanduser()
        cache_file.parent.mkdir(parents=True, exist_ok=True)
        path = Path(str(self.fm.thisfile))

        if path.is_dir():
            target = path.absolute()
        else:
            target = path.parent.absolute()

        with open(cache_file, 'a') as file_obj:
            file_obj.write(f'{str(path.name)}={str(target)}\n')

        self.fm.notify(f'{str(path.name)} added to saved playlists')


class bulkrename_torrent(Command):
    """:bulkrename_torrent
    This command opens a list of selected files in an external editor.
    After you edit and save the file, it will generate a shell script
    which does bulk renaming according to the changes you did in the file
    to the files in the downloaded, or downloading, torrent.
    This shell script is opened in an editor for you to review.
    After you close it, it will be executed.
    """

    @staticmethod
    def read_stig_output(cmd_return) -> str:
        return cmd_return.stdout.read().decode("utf-8").split("\n")[:-1]

    @staticmethod
    def filter_match(tor_id: int, filelist: list, ranger_files: list):
        new_filelist = []
        join_dict = {}
        for r_index, r_file in enumerate(ranger_files):
            for index, file in enumerate(filelist):
                if file.is_relative_to(r_file):
                    new_filelist.append(file)
                    join_dict[r_index] = {"tor_id": tor_id, "file_index": index}
                    break

        assert len(new_filelist) == len(join_dict), "Filelist and join are not the same length"
        return new_filelist, join_dict

    def execute(self):
        import tempfile
        import os
        from pathlib import Path
        import subprocess
        from ranger.container.file import File
        from ranger.ext.shell_escape import shell_escape as esc
        from ranger.ext.keybinding_parser import PY3

        # Getting all torrents from stig
        torrents_cmd = self.fm.run(
            ['stig', 'ls', '-c', 'id,name,path'],
            stdout=subprocess.PIPE
        )

        if torrents_cmd.returncode == 0:
            torrent_list = self.read_stig_output(torrents_cmd)
        else:
            self.fm.notify("There was an error fetching the torrent list")
            return

        # Getting selected files and their full and relative paths
        ranger_files = []
        for f in self.fm.thistab.get_selection():
            ranger_files.append(Path(f.path.replace(".part", "")))


        # creating torrents and fetching its attributes
        torrents = {}
        join_dict = {}
        for tor in torrent_list:
            tor_id, tor_name, tor_path = tor.split("\t")
            tor_id = int(tor_id)
            if any([tor_name in str(r_file.absolute()) for r_file in ranger_files]):
                # get filelist for each torrent
                torrent_files = self.fm.run(
                    ['stig', 'filelist', f'"{tor_name}"', '-c', 'name'],
                    stdout=subprocess.PIPE
                )

                if torrent_files.returncode == 0:
                    # read filelist from output
                    filelist = list(map(Path, self.read_stig_output(torrent_files)))
                else:
                    self.fm.notify(f"There was an error running filelist for {tor_name}")
                    return


                filelist, join = self.filter_match(tor_id, filelist, ranger_files)

                if filelist:
                    torrents[tor_id] = {
                            "name": tor_name,
                            "path": f"{tor_path}/{tor_name}",
                            "files": filelist
                        }
                    join_dict.update(join)

        filenames = [
                str(file.absolute()).replace(f"{self.fm.thistab.path}/", "")
                for file in ranger_files
            ]

        with tempfile.NamedTemporaryFile(delete=False) as listfile:
            listpath = listfile.name
            if PY3:
                listfile.write(
                        "\n".join(filenames)
                        .encode(encoding="utf-8", errors="surrogateescape")
                    )
            else:
                listfile.write(
                        "\n".join(filenames)
                    )

        self.fm.execute_file([File(listpath)], app='editor')

        with open(listpath, "r", encoding="utf-8", errors="surrogateescape") as listfile:
            new_filenames = listfile.read().split("\n")

        os.unlink(listpath)
        if all(a == b for a, b in zip(filenames, new_filenames)):
            self.fm.notify("No renaming to be done!")
            return

        # Generate script
        with tempfile.NamedTemporaryFile() as cmdfile:
            script_lines = [
                "# This file will be executed when you close the editor.",
                "# Please double-check everything, clear the file to abort.",
            ]
            for index, (old, new) in enumerate(zip(filenames, new_filenames)):
                if old != new:
                    if index not in join_dict.keys():
                        script_lines.append(
                            f"mv -vi -- {esc(old)} {esc(new)}"
                        )
                        continue

                    tor_id = join_dict[index]["tor_id"]
                    if old == torrents[tor_id]["name"]:
                        script_lines.append(
                            f"stig rename --unique -- id={tor_id} {esc(new)}"
                        )
                    else:
                        script_lines.append(
                            f"stig rename --unique -- id={tor_id}'{self.fm.thistab.path.replace(torrents[tor_id]['path'], '')}/{esc(old)}' {esc(new)}"
                        )

            # Make sure not to forget the ending newline
            script_content = "\n".join(script_lines) + "\n"
            if PY3:
                cmdfile.write(
                    script_content
                    .encode(encoding="utf-8", errors="surrogateescape")
                )
            else:
                cmdfile.write(script_content)
            cmdfile.flush()

            # Open the script and let the user review it, then check if the
            # script was modified by the user
            self.fm.execute_file([File(cmdfile.name)], app='editor')
            cmdfile.seek(0)
            script_was_edited = (script_content != cmdfile.read())

            # Do the renaming
            self.fm.run(['/bin/sh', cmdfile.name])

        # Retag the files, but only if the script wasn't changed during review,
        # because only then we know which are the source and destination files.
        if not script_was_edited:
            tags_changed = False
            for old, new in zip(filenames, new_filenames):
                if old != new:
                    oldpath = self.fm.thisdir.path + '/' + old
                    newpath = self.fm.thisdir.path + '/' + new
                    if oldpath in self.fm.tags:
                        old_tag = self.fm.tags.tags[oldpath]
                        self.fm.tags.remove(oldpath)
                        self.fm.tags.tags[newpath] = old_tag
                        tags_changed = True
            if tags_changed:
                self.fm.tags.dump()
