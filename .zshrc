# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/leerao/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

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

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias t='tmux'
alias v='vim'
alias p='python'
alias x='xdg-open'
alias cleves='ssh lrao1@cleves.ucsf.edu'
# alias turing='ssh lrao1@turing.ucsf.edu'
alias turing='ssh lrao1@169.230.81.52'
alias turingjn='ssh -N -L 8340:localhost:8340 lrao1@turing.ucsf.edu'
alias turingjn2='ssh -N -L 8341:localhost:8341 lrao1@turing.ucsf.edu'
alias cdl='cd /home/leerao/projects/LRRK2/'
alias cdc='cd /mnt/project/2018_03_PD/plates/CR_20201214_plate_2020032047_MS1-MS2_maxproj'
alias cdc1='cd /mnt/project/2018_03_PD/experiments/LRRK2_T-Rex/2020/20201106_ELNcomparison_T-Rex_v1'
alias cdcli='cd /mnt/project/2018_03_PD/plates/CR_20210405_plate_2021032011_t13'
alias cdring='cd /home/leerao/Software/Pipeline2020/pipeline_modules/features/CbFeatures_CR_Specialized_2021/src/RingParams/RingAndObjectParamsOptimizationScript'
alias cdp='cd /home/leerao/projects/phenotip-analysis'
alias ucsf='ssh lrao@log2.wynton.ucsf.edu'
alias puml='java -jar /home/leerao/Software/PlantUML/plantuml-1.2022.5.jar'
alias say='spd-say'

# function needed for scp to turing because I dont' want to type the 
# IP address every time (which is needed because UCSF IT messed up the domain name
# occassionally)
scptoturing () {
    scp -r "${1}" "lrao1@169.230.81.52:${2}" 
}
scpfromturing () {
    scp -r "lrao1@169.230.81.52:${1}" "${2}" 
}

bindkey -v

# fix code command in tmux in VSCode integrated terminal
if [ -n "$VSCODE_IPC_HOOK_CLI" ]; then
    socket=$(ls -1t /run/user/$UID/vscode-ipc-*.sock 2> /dev/null | head -1)
    export VSCODE_IPC_HOOK_CLI=${socket}
fi

# Adding to PATH
if which ruby >/dev/null && which gem >/dev/null; then
    export PATH="$(ruby -r rubygems -e 'puts Gem.user_dir')/bin:$PATH"
    export PATH="$(ascli config ascp show)/..:$PATH"
fi


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/leerao/Software/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/leerao/Software/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/leerao/Software/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/leerao/Software/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

