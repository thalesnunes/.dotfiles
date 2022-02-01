#!/usr/bin/env python
"""
Created on Apr 19, 2012
@author: dan, Faless

    GNU GENERAL PUBLIC LICENSE - Version 3

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.

    http://www.gnu.org/licenses/gpl-3.0.txt

"""

import shutil
import tempfile
import sys
import libtorrent as lt
from time import sleep
from argparse import ArgumentParser, Namespace
from pathlib import Path


def init_parser() -> Namespace:
    parser = ArgumentParser(
        description="A command line tool that converts magnet links in to .torrent files"  # noqa
    )
    parser.add_argument(
            "-m",
            "--magnet",
            help="The magnet url",
            action="store",
            required=True
    )
    parser.add_argument(
            "-o",
            "--output",
            help="The output torrent file name",
            action="store",
            required=True
    )
    return parser


def magnet2torrent(
    magnet: str, output_name: str
):

    output_name = Path(output_name)
    output_name.mkdir(exist_ok=True, parents=True)

    tempdir = tempfile.mkdtemp()
    ses = lt.session()
    params = {
        "save_path": tempdir,
        "storage_mode": lt.storage_mode_t(2),
    }
    handle = lt.add_magnet_uri(ses, magnet, params)

    print("Downloading Metadata (this may take a while)")
    while not handle.has_metadata():
        try:
            sleep(1)
        except KeyboardInterrupt:
            print("Aborting...")
            ses.pause()
            print("Cleanup dir " + tempdir)
            shutil.rmtree(tempdir)
            sys.exit(0)
    ses.pause()
    print("Done")

    torinfo = handle.get_torrent_info()
    torfile = lt.create_torrent(torinfo)

    if output_name.is_dir():
        output_file = output_name / (torinfo.name() + ".torrent")
    else:
        output_file = output_name

    print(f"Saving torrent file here : {output_file} ...")
    torcontent = lt.bencode(torfile.generate())
    with open(output_file, "wb") as f:
        f.write(torcontent)
    print("Saved! Cleaning up dir: " + tempdir)
    ses.remove_torrent(handle)
    shutil.rmtree(tempdir)

    return output_file


def main():

    parser = init_parser()

    args = parser.parse_args()

    magnet2torrent(args.magnet, args.output)


if __name__ == "__main__":
    main()
