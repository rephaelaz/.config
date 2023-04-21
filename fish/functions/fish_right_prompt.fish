function prompt_error
    set -l last_status $status
    if test $last_status -gt 0
        print $last_status black red
    end
end

# --------------------------------------------------------------

function prompt_elapsed
    set -l elapsed $CMD_DURATION
    set -l suffix "ms"
    if test $elapsed -gt 1000
        set elapsed (math $elapsed / 1000)
        set suffix "s"
    end
    print $elapsed$suffix black brblack
end

# --------------------------------------------------------------

function prompt_git
    if command git rev-parse --is-inside-work-tree >/dev/null 2>&1
        set -l ref (command git symbolic-ref HEAD 2> /dev/null)
        if test $status -gt 0
            set ref (command git show-ref --head -s --abbrev |head -n1 2> /dev/null)
        end
        set -l branch (echo $ref | sed "s#refs/heads/##")
        if test (string length $branch) -gt 15
            set branch (string replace -r "(.7).*(.6)" '$1..$2' $branch_name)
        end
        set -l dirty (command git status --porcelain 2> /dev/null)
        set -l color green
        # echo -n -s (set_color cyan)"("
        if test -n "$dirty"
            set color yellow
        end
        print $branch black $color
        # echo -n -s $branch
        # echo -n -s (set_color cyan)") "
        # set_color normal
    end
end

# --------------------------------------------------------------

set -g current_venv ""

function prompt_venv
    if test -d venv
        and test venv/bin/activate.fish 
        source venv/bin/activate.fish
        set current_venv (pwd)
    end
    if test -n $current_venv
        string match -q "$current_venv*" (pwd)
        if test $status -ne 0
            deactivate
            set current_venv ""
        end
    end
    if test $VIRTUAL_ENV
        print (basename $VIRTUAL_ENV) black purple
    end
end

function fish_right_prompt
    prompt_error
    prompt_elapsed
    prompt_git
    prompt_venv
    print $USER@$hostname black blue
end