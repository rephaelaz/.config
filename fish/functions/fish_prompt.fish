set -g current_venv ""

function fish_prompt
    # Activate/Deactivate virtualenv if a venv dir is found in pwd
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

    set -l path (basename (prompt_pwd))
    set -l python_version ''
    set -l branch ''
    set -l branch_dirty ''
    set -l color cyan

    # Python version calculation
    if test $VIRTUAL_ENV
        set python_version (string replace Python  (python --version))
    end

    # Git branch name calculation
    if command git rev-parse --is-inside-work-tree >/dev/null 2>&1
        set -l ref (command git symbolic-ref HEAD 2> /dev/null)
        if test $status -gt 0
            set ref (command git show-ref --head -s --abbrev |head -n1 2> /dev/null)
        end
        set branch ' '(echo $ref | sed "s#refs/heads/##")
        if test (string length $branch) -gt 15
            set branch ' '(string replace -r "(.7).*(.6)" '$1..$2' $branch_name)
        end
        set branch_dirty (command git status --porcelain 2> /dev/null)
    end

    set_color $color
    echo -n -s 
    set_color --bold black -b $color 
    echo -n -s $path
    if test -n $python_version; or test -n $branch
        echo -n -s ' '
    end
    if test -n $python_version
        set color brgreen
        set_color --bold black -b $color
        echo -n -s ' '$python_version
        if test -n $branch
            echo -n -s ' '
        end
    end
    if test -n $branch
        set color green
        if test -n "$branch_dirty"
            set color yellow
        end
        set_color --bold black -b $color
        echo -n -s ' '$branch
    end
    set_color normal
    set_color $color
    echo -n -s 
    set_color normal
    echo -n -s ' '
end