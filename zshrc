ZSH=$HOME/.oh-my-zsh

#export EDITOR="peepcode"

#export ZSH_TMUX_AUTOSTART=true

ZSH_THEME="clean"

export ZSH ZSH_AUTOSUGGEST_USE_ASYNC=1
export HISTFILESIZE=1000000000
export HISTSIZE=1000000000

setopt INC_APPEND_HISTORY
export HISTTIMEFORMAT="[%F %T] "

setopt EXTENDED_HISTORY
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS


# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
# alias vi="nvim"
alias grep="`which grep` --color=auto"
alias pip=pip3

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"
# ZSH_COLORIZE_STYLE="colorful"
# ZSH_COLORIZE_TOOL=chroma

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(aws git textmate ruby lighthouse)
#plugins=(tmux colorize aws vi-mode zsh-autosuggestions)
plugins=(colorize aws vi-mode)
source $ZSH/oh-my-zsh.sh

# alias ls="ls -haltrG"

unsetopt correct_all
unsetopt share_history

# minic osx open in linux
# alias open=xdg-open


# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$HOME/bin:$PATH"
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:/usr/local/bin:$PATH:$HOME/.emacs.d/bin"
export PATH="/opt/homebrew/lib/ruby/gems/3.0.0/bin:$PATH"


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# HSTR configuration - add this to ~/.zshrc
alias hh=hstr                    # hh to be alias for hstr
setopt histignorespace           # skip cmds w/ leading space from history
export HSTR_CONFIG=hicolor       # get more colors
bindkey -s "\C-r" "\C-a hstr -- \C-j"     # bind hstr to Ctrl-r (for Vi mode check doc)

bindkey '^ ' autosuggest-accept

export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/ruby/lib"
export CPPFLAGS="-I/opt/homebrew/opt/ruby/include"

export PKG_CONFIG_PATH="/opt/homebrew/opt/ruby/lib/pkgconfig"
export PATH="/opt/homebrew/opt/krb5/bin:$PATH"
export PATH="/opt/homebrew/opt/krb5/sbin:$PATH"

export LDFLAGS="-L/opt/homebrew/opt/krb5/lib"
export CPPFLAGS="-I/opt/homebrew/opt/krb5/include"

export PKG_CONFIG_PATH="/opt/homebrew/opt/krb5/lib/pkgconfig"

if type rg &> /dev/null; then
  export FZF_DEFAULT_COMMAND='rg --files'
  export FZF_DEFAULT_OPTS='-m --height 50% --border'
fi

export PATH="/usr/local/opt/python@3.8/bin:$PATH"

export LOCALSTACK_API_KEY=2k64SvR3Ti
export LOCALSTACK_LAMBDA_EXECUTOR=docker-reuse
export LOCALSTACK_LAMBDA_REMOTE_DOCKER=false
# export TMPDIR=/private$TMPDIR
# export HOST_TMP_FOLDER=${TMPDIR}
export TMPDIR=/Users/jvowell/tmp
export HOST_TMP_FOLDER=${TMPDIR}

export LOCALSTACK_SERVICES=rds,rds-data,s3,lambda,apigateway,iam,ssm,cloudwatch,secretsmanager
export LS_LOG=trace
export AWS_ACCESS_KEY_ID=test
export AWS_SECRET_ACCESS_KEY=test
