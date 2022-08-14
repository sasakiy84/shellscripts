PS1="\[\e[0;0;43m\] \# \[\e[0;33m\]\[\e[0m\]\[\e[0;30;46m\]\[\e[0;0;46m\] \D{%H:%M} \[\e[0;36m\]\[\e]0;\u: \w\a\]\[\e[0;30;42m\]\[\e[0;0;42m\] ${debian_chroot:+($debian_chroot)}\u \
[\e[0;32m\]\[\e[0;30;44m\]\[\e[0;0;44m\] \w \[\e[0;34m\] \[\e[00m\]\n \$ "

function add_line {
  if [[ -z "${PS1_NEWLINE_LOGIN}" ]]; then
    PS1_NEWLINE_LOGIN=true
  else
    printf '\n'
  fi
}
PROMPT_COMMAND='add_line'
