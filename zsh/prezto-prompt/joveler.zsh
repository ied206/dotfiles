#
# joveler, a theme for prezto.
# - The theme is based on the steeef of prezto.
# - Also influenced by bira of oh-my-zsh.
#
# Authors of steeef:
#   Steve Losh <steve@stevelosh.com>
#   Bart Trojanowski <bart@jukie.net>
#   Brian Carper <brian@carper.ca>
#   steeef <steeef@gmail.com>
#   Sorin Ionescu <sorin.ionescu@gmail.com>
# Authors of joveler:
#   Hajin Jang <jb6804@naver.com>
#
# Screenshots:
#   <None, yet>
#

function prompt_joveler_precmd {
  # Check for untracked files or updated submodules since vcs_info does not.
  if [[ -n $(git ls-files --other --exclude-standard 2> /dev/null) ]]; then
    branch_format="(${_prompt_joveler_color_vcs_branch}%b%f%u%c${_prompt_joveler_color_vcs_untracked}●%f)"
  else
    branch_format="(${_prompt_joveler_color_vcs_branch}%b%f%u%c)"
  fi

  zstyle ':vcs_info:*:prompt:*' formats "${branch_format}"

  vcs_info 'prompt'

  if (( $+functions[python-info] )); then
    python-info
  fi
}

function prompt_joveler_setup {
  setopt LOCAL_OPTIONS
  unsetopt XTRACE KSH_ARRAYS
  prompt_opts=(cr percent sp subst)

  # Load required functions.
  autoload -Uz add-zsh-hook
  autoload -Uz vcs_info

  # Add hook for calling vcs_info before each command.
  add-zsh-hook precmd prompt_joveler_precmd

  # Tell prezto we can manage this prompt
  zstyle ':prezto:module:prompt' managed 'yes'

  # Check if terminal supports 256 colors.
  if [[ $TERM = *256color* || $TERM = *rxvt* ]]; then
    local is_term256=true
  else
    local is_term256=false
  fi

  # Use extended color pallete if available.
  if [ "$is_term256" = true ]; then
    _prompt_joveler_color_pwd="%F{118}" # Limegreen
    _prompt_joveler_color_user="%F{141}" # Purple
    _prompt_joveler_color_vcs_branch="%F{178}" # Orange
    _prompt_joveler_color_vcs_untracked="%F{161}" # Hotpink
    _prompt_joveler_color_vcs_action="%F{118}" # Limegreen
    _prompt_joveler_color_vcs_unstaged="%F{166}" # Orange
    _prompt_joveler_color_vcs_staged="%F{118}" # Limegreen
  else
    _prompt_joveler_color_pwd="%F{green}"
    _prompt_joveler_color_user="%F{blue}"
    _prompt_joveler_color_vcs_branch="%F{yellow}"
    _prompt_joveler_color_vcs_untracked="%F{red}"
    _prompt_joveler_color_vcs_action="%F{green}"
    _prompt_joveler_color_vcs_unstaged="%F{yellow}"
    _prompt_joveler_color_vcs_staged="%F{green}"
  fi

  # root only
  if [[ $UID -eq 0 ]]; then
    _prompt_joveler_color_pwd="%F{red}"
  fi

  # Useful palette
  # "%F{135}" # MediumPurple2 (slighty more darker)
  # "%F{141}" # MediumPurple1 (slighty less darker)
  # "%F{166}" # Orange
  # "%F{81}" # Turquoise

  # Formats:
  #   %b - branchname
  #   %u - unstagedstr (see below)
  #   %c - stagedstr (see below)
  #   %a - action (e.g. rebase-i)
  #   %R - repository path
  #   %S - path in the repository
  local branch_format="(${_prompt_joveler_color_vcs_branch}%b%f%u%c)"
  local action_format="(${_prompt_joveler_color_vcs_action}%a%f)"
  local unstaged_format="${_prompt_joveler_color_vcs_unstaged}●%f"
  local staged_format="${_prompt_joveler_color_vcs_staged}●%f"

  # Set editor-info parameters.
  # Use $ in normal user, # in root.
  if [[ $UID -eq 0 ]]; then
    zstyle ':prezto:module:editor:info:keymap:primary' format '#'
  else
    zstyle ':prezto:module:editor:info:keymap:primary' format '$'
  fi

  # Set vcs_info parameters.
  zstyle ':vcs_info:*' enable bzr git hg svn
  zstyle ':vcs_info:*:prompt:*' check-for-changes true
  zstyle ':vcs_info:*:prompt:*' unstagedstr "${unstaged_format}"
  zstyle ':vcs_info:*:prompt:*' stagedstr "${staged_format}"
  zstyle ':vcs_info:*:prompt:*' actionformats "${branch_format}${action_format}"
  zstyle ':vcs_info:*:prompt:*' formats "${branch_format}"
  zstyle ':vcs_info:*:prompt:*' nvcsformats   ""

  # Set python-info parameters.
  zstyle ':prezto:module:python:info:virtualenv' format '(%v)'

  # Define prompts.
  PROMPT="
${_prompt_joveler_color_user}%n@%m%f %{$terminfo[bold]%}${_prompt_joveler_color_pwd}%~%f% %{$terminfo[sgr0]%} "'${vcs_info_msg_0_}'"
"'$python_info[virtualenv]${editor_info[keymap]} '
  RPROMPT=''
}

function prompt_joveler_preview {
  local +h PROMPT=''
  local +h RPROMPT=''
  local +h SPROMPT=''

  editor-info 2> /dev/null
  prompt_preview_theme 'joveler'
}

prompt_joveler_setup "$@"
# vim: ft=zsh
