#!/bin/zsh
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
    if [ $VIRTUAL_ENV ]
    then
        local project_root=`cat $VIRTUAL_ENV/.project`
        local in_project=false

        if [[ ${PWD} =~ "$project_root.*$" ]]
        then
            in_project=true
        fi


        if [ $COLOR_CAPABILITY ]
        then
            if [[ $in_project == true ]]
            then
                echo " %{$reset_color%}workon:%{$fg[blue]%}"`basename $VIRTUAL_ENV`"%{$reset_color%}"
            else
                echo " %{$reset_color%}workon:%{$fg[magenta]%}"`basename $VIRTUAL_ENV`"%{$reset_color%}"
            fi
        else
            echo "workon:"`basename $VIRTUAL_ENV`
        fi
    fi
}
local virtualenv_info_prompt='$(virtualenv_info)'

# chris@bennett-mbp:~ 169 15:49:38
# USER@host:PATH (git) 
PROMPT="%{$terminfo[bold]%F{248}%}–%{$reset_color%} \
%F{104}%n@%m%f\
%{$fg[black]%}:${current_dir}\
${virtualenv_info_prompt}${git_info} %F{244}%! %*%f
%{$terminfo[bold]$fg[black]%}%(!.%{$fg[red]%}%#.%%) %{$reset_color%}"

if [ -z $COLOR_CAPABILITY ]
then
    ZSH_THEME_GIT_PROMPT_PREFIX=" git:"
    ZSH_THEME_GIT_PROMPT_SUFFIX=""
    ZSH_THEME_GIT_PROMPT_DIRTY=" x"
    ZSH_THEME_GIT_PROMPT_CLEAN=" o"
    PROMPT="– % \
%n@%m:${current_dir}\
${virtualenv_info_prompt}\
${git_info}\
%! %*
%(!.#.%%) "
fi
