local ret_status="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )"
local exit_code="%(?::%{$fg_bold[red]%}Exit code: %? )"

PROMPT='----------
%* %{$fg_bold[cyan]%}${PWD/#$HOME/~}$reset_color%}
$(git_prompt_info)
${exit_code}$reset_color${ret_status}$reset_color'
# RPROMPT='%*'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
