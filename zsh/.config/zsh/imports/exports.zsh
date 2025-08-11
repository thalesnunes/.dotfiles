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

# Docker Dracula theme
export BUILDKIT_COLORS="run=189,147,249:cancel=241,250,140:error=255,85,85:warning=241,250,140"

# BAT theme
export BAT_THEME='Dracula'

# EZA Dracula theme
export EZA_COLORS="\
uu=36:\
uR=31:\
un=35:\
gu=37:\
da=2;34:\
ur=34:\
uw=95:\
ux=36:\
ue=36:\
gr=34:\
gw=35:\
gx=36:\
tr=34:\
tw=35:\
tx=36:\
xx=95:"
