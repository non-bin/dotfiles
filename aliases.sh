alias l="exa -laFg --colour-scale --icons --group-directories-first"
alias t=tree
alias tree="exa -aFTL3 --icons --group-directories-first"
# exa options
# -l Long
# -a All
# -F Put / after dirs etc.
# --colour-scale Colour gradient on file sizes
# --icons Show file type icons
# --group-directories-first
# -g Display owning group
#
# -T Tree
# -L# How far to recurse

alias watch="watch -n 1 -c -d "
alias ip="ip -c"
alias grep="grep --color -A 2"
alias cp='rsync -pogbr -hhh --backup-dir=/tmp/rsync -e /dev/null --progress --partial' # preserve permissions, owner, & group, backup, to /tmp/rsync, disable remote (?), show progress, keep partially transfered files
alias mkdir='mkdir -pv' # create parents, and list each as it is created
alias sudo='sudo -E ' # preserve env

alias agi='sudo apt install'
alias agu='sudo apt update'
alias agug='sudo apt upgrade'

alias g="git"
alias ga="git add"
alias gaa="git add --all"
alias gc="git commit -v"
alias gp="git push"
alias gl="git pull"
