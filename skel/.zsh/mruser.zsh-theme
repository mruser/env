# Directory info.
local current_dir='${PWD/#$HOME/~}'

# Git info.
local git_info='$(git_prompt_info)'
ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg[white]%}%{$reset_color%}git:%{$fg[cyan]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}x"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$fg[green]%}o"

# virtualenv info
function virtualenv_info {
    [ $VIRTUAL_ENV ] && echo '('`basename $VIRTUAL_ENV`') '
}

# chris@bennett-mbp:~ 169 15:49:38
# USER@host:PATH (git) 
PROMPT="%{$terminfo[bold]%F{248}%}–%{$reset_color%} \
%F{104}%n@%m%f\
%{$fg[black]%}:${current_dir}\
%{$reset_color%}\
${git_info} \
$(virtualenv_info) \
%F{244}%! %*%f
%{$terminfo[bold]$fg[black]%}%(!.%{$fg[red]%}%#.%%) %{$reset_color%}"

if [ -z $COLOR_CAPABILITY ]
then
    ZSH_THEME_GIT_PROMPT_PREFIX=" git:"
    ZSH_THEME_GIT_PROMPT_SUFFIX=""
    ZSH_THEME_GIT_PROMPT_DIRTY=" x"
    ZSH_THEME_GIT_PROMPT_CLEAN=" o"
    PROMPT="– % \
%n@%m:${current_dir}\
${git_info} \
$(virtualenv_info) \
%! %*
%(!.#.%%) "
fi
