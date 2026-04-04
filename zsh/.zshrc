# Zsh configuration file for both login mode and interactive mode
#
# .profile file in Bash

#
# General Settings
# ==============================================================================

#
# XDG_CONFIG_HOME
#
export XDG_CONFIG_HOME=$HOME/.config

#
# Bind-key
# ------------------------------------------------------------------------------
bindkey -e

#
# Command Alias
# ------------------------------------------------------------------------------

#
# History
# ------------------------------------------------------------------------------
export HISTFILE=${HOME}/.zsh_history
export HISTSIZE=5000 # default 2000
export SAVEHIST=$HISTSIZE
export HISTDUP=erase
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

#
# Prompt
# ==============================================================================
export PS1="%~ $ "

#
# Terminal Specified Settings
# ==============================================================================

#
# Apple Terminal
# ------------------------------------------------------------------------------
#
# see https://zenn.dev/sprout2000/articles/bd1fac2f3f83bc
# $ brew install zsh-git-prompt
if [ "$TERM_PROGRAM" = "Apple_Termanil" ]; then
  alias python="python3"
  if [ -f "$(brew --prefix zsh-git-prompt)/zshrc.sh" ]; then
    GIT_PROMPT_THEME=Default
    source "$(brew --prefix zsh-git-prompt)/zshrc.sh"
  fi

  git_prompt() {
    # $'\n' で改行
    # see https://qiita.com/ko1nksm/items/af780da4a8ef8b1c5beb
    if [ "$(git rev-parse --is-inside-work-tree 2> /dev/null)" = true ]; then
      PROMPT='%B%~%b$(git_super_status)'$'\n''%F{white}[%T]%f %(!.#.$) '
    else
      PROMPT='%B%~%b'$'\n''%F{white}[%T]%f %(!.#.$) '
    fi
  }

  precmd() {
    git_prompt
  }

#
# WezTerm
# ------------------------------------------------------------------------------

elif [ "$TERM_PROGRAM" = "WezTerm" ]; then
  export STARSHIP_CONFIG=$HOME/.config/starship/starship.toml
  eval "$(starship init zsh)"

  function wezterm-set-active-pane-title() {
    echo "\x1b]1;$@"
  }

#
# Ghostty
# ------------------------------------------------------------------------------

elif [ "$TERM_PROGRAM" = "ghostty" ]; then
  export STARSHIP_CONFIG=$HOME/.config/starship/starship.toml
  eval "$(starship init zsh)"

#
# iTerm 2 and tmux
# ------------------------------------------------------------------------------

else
  eval "$(oh-my-posh init zsh --config $(brew --prefix oh-my-posh)/themes/powerlevel10k_rainbow.omp.json)"
fi

#
# Integration for OSC 133
# ------------------------------------------------------------------------------
# https://gitlab.freedesktop.org/Per_Bothner/specifications/blob/master/proposals/semantic-prompts.md
# https://gitlab.freedesktop.org/Per_Bothner/specifications/-/blob/master/proposals/prompts-data/shell-integration.zsh

_prompt_executing=""
function __prompt_precmd() {
  local ret="$?"
  if test "$_prompt_executing" != "0"
  then
    _PROMPT_SAVE_PS1="$PS1"
    _PROMPT_SAVE_PS2="$PS2"
    PS1=$'%{\e]133;P;k=i\a%}'$PS1$'%{\e]133;B\a\e]122;> \a%}'
    PS2=$'%{\e]133;P;k=s\a%}'$PS2$'%{\e]133;B\a%}'
  fi
  if test "$_prompt_executing" != ""
  then
    printf "\033]133;D;%s;aid=%s\007" "$ret" "$$"
  fi
  printf "\033]133;A;cl=m;aid=%s\007" "$$"
  _prompt_executing=0
}
function __prompt_preexec() {
  PS1="$_PROMPT_SAVE_PS1"
  PS2="$_PROMPT_SAVE_PS2"
  printf "\033]133;C;\007"
  _prompt_executing=1
}
preexec_functions+=(__prompt_preexec)
precmd_functions+=(__prompt_precmd)


#
# Customize Zsh
# ==============================================================================


#
# Zsh Color
# ------------------------------------------------------------------------------

autoload -Uz colors
colors

zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

#
# Zsh Completions
# ------------------------------------------------------------------------------
#
# $ rm -f ~/.zcompdump; compinit
# $ chmod go-w '/opt/homebrew/share'
# $ chmod -R go-w '/opt/homebrew/share/zsh'

if type brew &>/dev/null; then
  fpath=(~/.zsh/completions $(brew --prefix)/share/zsh-completions $fpath)

  autoload -Uz compinit
  compinit
fi

#
# Zsh autosuggestion
# ------------------------------------------------------------------------------
#
# $ brew install zsh-autosuggestions

source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

#
# Zsh syntax highlighting
# ------------------------------------------------------------------------------
#
# $ brew install zsh-syntax-highlighting

source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

#
# Customize App
# ==============================================================================

#
# Common
# - Claude
# ------------------------------------------------------------------------------
export PATH=$HOME/.local/bin:$PATH

#
# Bat
# ------------------------------------------------------------------------------
if type bat &>/dev/null; then
  export MANPAGER="sh -c 'col -bx | bat --language=man --style=plain'"
fi

#
# Emacs
# ------------------------------------------------------------------------------
emacs_dir=$HOME/project/emacs-build
alias emacs="open $emacs_dir/nextstep/Emacs.app/"
export EDITOR="$emacs_dir/lib-src/emacsclient"
export GIT_EDITOR="$emacs_dir/lib-src/emacsclient"

#
# Eza -- Better ls
# ------------------------------------------------------------------------------
#
# brew install eza
# brew install tree

if [ -f "/opt/homebrew/bin/eza" ]; then
  alias ls='eza --group-directories-first --icons --no-user'
  alias lt='eza --group-directories-first --icons --no-user --tree '
  alias lt3='eza --git-ignore --group-directories-first --icons --no-user --tree --level=3'
else
  alias ls='ls -kFG'
  alias lt='tree'
fi

#
# Git
# ------------------------------------------------------------------------------

function git-preview-branch() {
  local options_all=false

  while (( $# > 0 )); do
    case "$1" in
      --all)
        options_all=true
        shift
        ;;
      *)
        shift
        break
        ;;
    esac
  done

  if [[ "${options_all}" == true ]]; then
    git branch --all | \
      fzf --height 60% \
          --multi \
          --preview="echo {} | \
                 sed -e 's/^.//' | \
                 xargs git log --graph --color=always --format=format:'%C(cyan)%ar %C(yellow)%an %C(white)%s'" | \
      sed -e 's/^.//' | \
      sed -e 's#remotes/origin/##'
  else
    git branch | \
      fzf --height 60% \
          --multi \
          --preview="echo {} | \
                 sed -e 's/^.//' | \
                 xargs git log --graph --color=always --format=format:'%C(cyan)%ar %C(yellow)%an %C(white)%s'" | \
      sed -e 's/^.//'
  fi
}

function git-preview-worktree() {
  git worktree list | \
    fzf --height 60% \
        --bind 'ctrl-/:change-preview-window(down|hidden|)' \
        --multi \
        --preview="echo {3} && \
                   echo '---' && \
                   echo {3} | \
                   sed -E 's/\[(.+)\]/\1/' | \
                   xargs git log --graph --color=always --format=format:'%C(cyan)%ar %C(yellow)%an %C(white)%s'" | \
    awk '{print $1}'
}

function git-preview-worktree-create() {
  local change_directory=false
  local create_new_branch=false

  while (( $# > 0 )); do
    case "$1" in
      --change-directory)
        change_directory=true
        shift
        ;;
      --create-new-branch)
        create_new_branch=true
        shift
        ;;
      *)
        shift
        break
        ;;
    esac
  done

  # Case
  # 1. has {REPO}_worktrees dir
  #   a. work_dir = {REPO}
  #   b. work_dir = {REPO}_worktrees/{JIRA_ID}_{desc}
  #   c. work_dir = {REPO}_worktrees/{desc}
  # 2. not has REPO_worktrees dir
  #   d. work_dir = {REPO}
  #   e. work_dir = {REPO}_{JIRA_ID}_{desc}
  #   f. work_dir = {REPO}_{desc}
  local repo_url=$(git remote get-url origin)
  local repo_name=$(basename -s .git $repo_url)
  local worktree_dir_suffix=worktrees
  local worktree_dir=${repo_name}_${worktree_dir_suffix}

  local branch
  local ticket_id
  local desc

  if [[ "${create_new_branch}" == true ]]; then
    read -r "ticket_id?チケット番号 (eg. JIRA-123): "
    read -r "desc?ブランチの説明を - 区切りで: "

    branch="feature/${ticket_id}_${desc}"
  else
    branch=$(git-preview-branch --all | xargs echo)

    # branch = feature/JIRA-123_desc
    if [[ $branch =~ ([A-Z]+-[0-9]+)_(.+) ]]; then
      ticket_id=$match[1]
      desc=$match[2]
      # branch = support/desc
    elif [[ $branh =~ ([a-z]+)/(.+) ]]; then
      desc=$match[2]
    else
      echo "Unexpected branch name:" $branch
      exit 1
    fi
  fi

  local dir
  # current dir -> case a.
  if [[ -d ../${worktree_dir} && -n ticket_id ]]; then
    dir=../$worktree_dir/${ticket_id}_${desc}
  elif [[ -d ../${worktree_dir} ]]; then
    dir=../$worktree_dir/${desc}
    # current dir -> case b. or c.
  elif [[ -d ../../${worktree_dir} && -n ticket_id ]]; then
    dir=../${ticket_id}_${desc}
  elif [[ -d ../../${worktree_dir} ]]; then
    dir=../${ticket_id}_${desc}
    # current dir -> case d. or e. or f.
  elif [[ -n $ticket_id ]]; then
    dir=../${repo_name}_${ticket_id}_${desc}
  else
    dir=../${repo_name}_${desc}
  fi

  if [[ "${create_new_branch}" == true ]]; then
    echo "\033[32mgit worktree add ${dir} -b ${branch}\033[0m"
    git worktree add $dir -b $branch
  else
    echo "\033[32mgit worktree add ${dir} ${branch}\033[0m"
    git worktree add $dir $branch
  fi

  if [[ "${change_directory}" == true ]]; then
    echo "\033[32mcd ${dir}\033[0m"
    cd $dir
  fi
}

#
# Homebrew
# ------------------------------------------------------------------------------
export BREW=/opt/homebrew/bin/brew
# 10 分間は AUTO UPDATE を無効にする
export HOMEBREW_AUTO_UPDATE_SECS=600

#
# Rbenv
# ------------------------------------------------------------------------------
#
# $ brew install rbenv
# $ rbenv install --list
# $ rbenv install 3.3.4
# $ rbenv global  3.3.4
export PATH=$HOME/.rbenv/bin:$HOME/bin:$PATH
eval "$(rbenv init - zsh)"

#
# Zoxide -- Better cd
# ------------------------------------------------------------------------------
#
# brew install zoxcide

if type zoxide &>/dev/null; then
  eval "$(zoxide init --cmd cd zsh)"
fi

#
# fzf
#
# brew install fzf

if type fzf &>/dev/null; then
  source <(fzf --zsh)

  export FZF_CTRL_T_OPTS="
         --walker-skip .git,node_modules,target
         --preview 'bat -n --color=always {}'
         --bind 'ctrl-/:change-preview-window(down|hidden|)'"

  export FZF_CTRL_R_OPTS="
         --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
         --color header:italic
         --header 'Press CTRL-Y to copy command into clipboard'"

  bindkey '^L' fzf-history-widget # overwrite clean-screen

  if type eza &>/dev/null; then
    export FZF_ALT_C_OPTS="
           --walker-skip .git,node_modules,target
           --preview 'eza --color=always --git-ignore --icons --no-user --tree {}'"
  elif type tree &>/dev/null; then
    export FZF_ALT_C_OPTS="
           --walker-skip .git,node_modules,target
           --preview 'tree -C {}'"
  fi
fi

#
# Atuin
# ------------------------------------------------------------------------------
#
# fzf の設定の後で Atuin の設定をしないと Ctrl-R が fzf の設定で上書きされます。

if type atuin &>/dev/null; then
  eval "$(atuin init zsh)"
fi

#
# Local settings
# ==============================================================================

if [ -f $HOME/.zshrc.local ]; then
  source $HOME/.zshrc.local
fi

#
# Memo
# ==============================================================================

# .authinfo の中身を利用する方法
#
# authinfo_github=$(grep 'machine github.com' ~/.authinfo)
# username_github=$(echo $authinfo_github | awk '{print $4}')
# password_github=$(echo $authinfo_github | awk '{print $6}')
#
# export GITHUB_API_TOKEN=$password_github
