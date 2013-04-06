# Directory info.
local current_dir='${PWD/#$HOME/~}'

# Git info.
local git_info='$(git_prompt_info)'
ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg[white]%}%{$reset_color%}git:%{$fg[cyan]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}x"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$fg[green]%}o"

# chris@bennett-mbp:~ 169 15:49:38
# USER@host:PATH (git) 
PROMPT="%{$terminfo[bold]%F{248}%}–%{$reset_color%} \
%F{104}%n@%m%f\
%{$fg[black]%}:${current_dir}\
%{$reset_color%}\
${git_info} \
%F{244}%! %*%f
%{$terminfo[bold]$fg[black]%}%(!.%{$fg[red]%}%#.%%) %{$reset_color%}"
