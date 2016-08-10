# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

setopt NO_HUP
unsetopt share_history
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

alias ll='ls -lF'
alias la='ls -A'
alias l='ls -CF'
alias lal='ls -al'
alias lc='ls *.c'
alias e='/Applications/Emacs.app/Contents/MacOS/Emacs'
alias logoff='gnome-session-save --kill --silent'
alias get='sudo apt-get install'
alias enw='emacs -nw '
alias org='emacs ~/org/planner.org&'
alias orgn='emacs -nw ~/org/planner.org'
alias note='emacs -nw --eval "(make-capture-frame) "'

function get_term_name
{
	echo "default"
}

function tm-create-or-attach
{
   	if [ "$TMUX" = "" ]; then
		tmux has-session -t ${1} > /dev/null 2>&1
		if [ "$?" != "0" ]; then
			tmux new-session -s ${1}
		else
			tmux attach -t ${1}
		fi
		exit
	fi
}

tm-create-or-attach $(get_term_name)

function tm-new
{
	OLD_TMUX=${TMUX}
	if [ "$1" = "" ]; then
		name=`basename $(pwd) | cut -d "." -f1`
	else
		name=$1
	fi
	TMUX=
	tmux new-session -d -s ${name}
	tmux switch-client -t ${name}
	TMUX=${OLD_TMUX}
}

git_prompt() {
	local ref=$(git symbolic-ref HEAD 2>/dev/null| cut -d'/' -f3)
	if [ "$ref" != "" ]; then
		echo ":($ref)"
	fi
	unset ref
}

##
## Vagrant Commands
##
alias vssh='vagrant ssh'
alias vup='vagrant up'
alias vhalt='vagrant halt'

export PS1="%U%*%u %F{cyan}%B%n %1~%f%b\$(git_prompt)%F{cyan} [%j]%B %(?.%#.%S[%?]!%s)%b%f "

## Don't allow tmux to change window name automatically
DISABLE_AUTO_TITLE=true

export PATH=$PATH:/home/harshad/.gem/ruby/2.2.0/bin

if [ "$SSH_TTY" != "" ]; then
    ## Things that are different for an SSH session
    tmux set-option prefix C-q>/dev/null 2>&1
fi
