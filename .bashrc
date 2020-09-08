#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return


# if [[ ${EUID} == 0 ]]; then
#     PS1="\[\e[31m\]\u\[\e[m\]\[\e[31m\]@\[\e[m\]\[\e[31m\]\h\[\e[m\]\[\e[34m\] \A\[\e[m\] \[\e[31m\]\w\[\e[m\]\n\[\e[31m\]\\#:\[\e[m\] "
# fi

# PS1='[\u@\h \W]\$ '
PS1="\[\e[32m\]\u\[\e[m\]\[\e[32m\]@\[\e[m\]\[\e[32m\]\h\[\e[m\]\[\e[34m\] \A\[\e[m\] \[\e[31m\]\w\[\e[m\]\n\[\e[32m\]\\$:\[\e[m\] "

# Чтобы терминал понимал, что он может показать 256 цветов, ему надо об этом сказать:
case "$TERM" in
        'xterm') TERM=xterm-256color;;
        'screen') TERM=screen-256color;;
        'Eterm') TERM=Eterm-256color;;
    esac

# --> ALIAS
# алиасы можно вынести в отдельный файл для удобства
#if [[ -r "${BASH_CONFIG_DIR}/bash_alias" ]]; then
#    source "${BASH_CONFIG_DIR}/bash_alias"
#fi

# включение поддержки цветного вывода некоторых команд
# если она установлена в системе
if [[ -x $( type -p dircolors ) ]]; then
        eval "$( dircolors -b )"
#         alias ls='clear && ls --group-directories-first --color=auto'
        alias ls='ls --group-directories-first --color=auto'
        alias dir='dir --color=auto --format=vertical'
        alias vdir='vdir --color=auto'
        alias grep='grep --color=auto'
        alias fgrep='fgrep --color=auto'
        alias egrep='egrep --color=auto'
fi

# alias для различных команд
alias dmesg='dmesg --color=always'
alias grep='grep --color=always'
alias gcc='gcc -fdiagnostics-color=always'
alias pacman='pacman --color=always'
# alias ll='ls -lhp'
# alias lf='ls -lhF'
# alias la='ls -lhap'
alias ping='ping -c 5'
# alias pwgen='pwgen -syc'
alias top='htop'
# alias rsync='rsync -P'
# df - вывод в человекопонятном виде, выводим типы ФС
alias df='df --human-readable --print-type'
alias ip='ip -color=auto'
# alias ls='ls --color=auto'

# --> НАСТРОЙКИ СОХРАНЕНИЯ ИСТОРИИ КОМАНД
# файл для хранения истории команд
# export HISTFILE="${BASH_CONFIG_DIR}/bash_history"
# принудительное вкл. настроек ignoredups и ignorespace
# ignoredups - не сохранять строки, совпадающие с последней выполненной
# командой
# ignorespace - не сохранять команды, начинающиеся с пробела
export HISTCONTROL="ignoreboth"
# Не сохранять в истории вызовы перечисленных комманд:
export HISTIGNORE="&:ls:[bf]g:exit:history"
# сохранить все строки многострочной команды в одной записи списка истории
# это позволяет легко редактировать многострочные команды.
shopt -s cmdhist
# настройки длины списка истории команд устанавливаются при
# помощи HISTSIZE и HISTFILESIZE (man bash)
# append to the history file, don't overwrite it
shopt -s histappend
export HISTSIZE=1000
export HISTFILESIZE=10000
# сохранять историю команд мгновенно, а не после завершения текущей сессии
PROMPT_COMMAND='history -a'
# <-- НАСТРОЙКИ СОХРАНЕНИЯ ИСТОРИИ КОМАНД
