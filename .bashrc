export PS1='\[\e[01;32m\]\u@\h\[\e[m\]:\[\e[01;34m\][\w]\[\e[m\] \[\e[1;36m\]<\t>\[\e[m\]\$ '
# if root
#export PS1='\[\e[01;31m\]\u@\h\[\e[m\]:\[\e[01;34m\][\w]\[\e[m\] \[\e[1;36m\]<\t>\[\e[m\]\$ '

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias fcode='astyle -A10SNYpHUk1W3cnQz1'

function arm-linux-gnueabi-ldd
{
    arm-linux-gnueabi-readelf -d $1 | grep -A 10 "Shared Library:"
}
