# FZF dracula colorscheme
export FZF_DEFAULT_OPTS="--color=fg:#f8f8f2,hl:#bd93f9 "\
"--color=fg+:#f8f8f2,hl+:#bd93f9 "\
"--color=info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6 "\
"--color=marker:#ff79c6,spinner:#ffb86c,header:#6272a4 "

# ZSH time command format
export TIMEFMT='%J   %U  user %S system'$'\n'\
'cpu %%:                     %P'$'\n'\
'elapsed time:              %E'$'\n'\
'max memory:                %M MB'$'\n'\
'avg shared (code):         %X KB'$'\n'\
'avg unshared (data/stack): %D KB'$'\n'\
'total (sum):               %K KB'$'\n'\
'page faults from disk:     %F'$'\n'\
'other page faults:         %R'

# Docker ps more informative format
export DOCKER_FORMAT="ID\t{{.ID}}\n"\
"NAME\t{{.Names}}\n"\
"IMAGE\t{{.Image}}\n"\
"PORTS\t{{.Ports}}\n"\
"COMMAND\t{{.Command}}\n"\
"CREATED\t{{.CreatedAt}}\n"\
"STATUS\t{{.Status}}\n"

# BAT theme
export BAT_THEME='Dracula'
