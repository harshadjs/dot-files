# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\[[\033[01;34m\]\u@\h:\W\[\033[00m\]]\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

function prompt() {
	underline=`tput smul`
	nounderline=`tput rmul`
	bold=`tput bold`
	normal=`tput sgr0`

	## Choice 1
	PS1='$(a=$?; echo -n "\[$(tput setaf 6)\]\[$(tput smul)\]\u@\h\[$(tput sgr0)\] \W " ; if [ $a -ne 0 ]; then echo -n "\[$(tput setaf 1)\]\[$(tput bold)\][$a]\[$(tput sgr0)\] "; fi; echo -n "◣ ")'

	## Choice 2
	PS1='$(a=$?; echo -n "\[\033[40;1;37m\]\t \[$(tput setaf 6)\]\u@\h\[$(tput sgr0)\] \W " ; if [ $a -ne 0 ]; then echo -n "\[$(tput setaf 1)\]\[$(tput bold)\][$a]\[$(tput sgr0)\] "; fi; echo -n "◣ ")'
}
# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -lF'
alias la='ls -A'
alias l='ls -CF'
alias lal='ls -al'
alias lc='ls *.c'
alias e='emacs'
alias logoff='gnome-session-save --kill --silent'
alias get='sudo apt-get install'
alias enw='emacs -nw '

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

if [ "$TMUX" = "" ]; then
	tmux attach
	if [ "$?" != "0" ]; then
		tmux has-session -t work > /dev/null 2>&1
		if [ "$?" != "0" ]; then
			tmux new-session -s work
		else
			tmux attach -t work
		fi
	fi
	exit
fi

export CVSROOT=:ext:harshads@cvs:/usr/local/cvsroot
export EDITOR=emacs

function tm-new
{
	OLD_TMUX=${TMUX}
	name=`basename $(pwd)`
	TMUX=
	tmux new-session -d -s ${name}
	tmux switch-client -t ${name}
	TMUX=${OLD_TMUX}
}


function tm-music
{
	tmux has-session -t Music
	if [ $? -ne 0 ]; then
		cd ~/Music/
		tm-new
		cd -
	else
		tmux switch-client -t Music
	fi
}



function platform
{
    if [ "$1" = "c50" ]; then
	export PLATFORM_TYPE=PLATFORM_LITEON_AP83
	export PATH=/export/tools-ap83/bin:$PATH
	export CC=mips-linux-gcc
	echo "PLATFORM_TYPE = $PLATFORM_TYPE, PATH = $PATH"
    elif [ "$1" = "c10" ]; then
	export PLATFORM_TYPE=PLATFORM_LITEON_PB44
	export PATH=/export/tools-ap83/bin:$PATH
	export CC=mips-linux-gcc
	echo "PLATFORM_TYPE = $PLATFORM_TYPE, PATH = $PATH, CC=$CC"
    elif [ "$1" = "c60" ]; then
	export PLATFORM_TYPE=PLATFORM_LITEON_DB12x
	export PATH=/export/tools-db120/usr/bin:$PATH
	export CC=mips-linux-gcc
	echo "PLATFORM_TYPE = $PLATFORM_TYPE, PATH = $PATH, CC=$CC"
    elif [ "$1" = "c55" ]; then
	export PLATFORM_TYPE=PLATFORM_SENAO_CAP4200
	export PATH=/export/tools-db120/usr/bin:$PATH
	export CC=mips-linux-gcc
	echo "PLATFORM_TYPE = $PLATFORM_TYPE, PATH = $PATH, CC=$CC"
    elif [ "$1" = "o70" ]; then
	export PLATFORM_TYPE=PLATFORM_SENAO_OAP6200AG
	export PATH=/export/tools-oap6200ag/bin/:$PATH
	export CC=powerpc-linux-gcc-4.5.1
	echo "PLATFORM_TYPE = $PLATFORM_TYPE, PATH = $PATH, CC=$CC"
    elif [ "$1" = "c75" ]; then
	export PLATFORM_TYPE=PLATFORM_LITEON_AP135
	export PATH=/export/tools-ap135/usr/bin/:$PATH
	export CC=mips-linux-gcc
	echo "PLATFORM_TYPE = $PLATFORM_TYPE, PATH = $PATH, CC=$CC"
    else
	echo "Invalid argument. Valid arguments are : c10, c50, c55, c60, o70, c75"
    fi
}

TPAD_DEVICE=15

function tpad0 {
	xinput set-prop ${TPAD_DEVICE} "Device Enabled" 0
}

function tpad1 {
	xinput set-prop ${TPAD_DEVICE} "Device Enabled" 1
}

prompt

str=`tmux display-message -p "#S"`
if [ "$str" = "Music" ]; then
	echo "harshad" > /tmp/file
	## Entering Music session
	str=`ps aux | grep mp3blaster | grep -v grep`
	echo "$str" >> /tmp/file
	if [ "$str" = "" ]; then
		mp3blaster
	fi
fi
