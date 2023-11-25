function fish_right_prompt
    set -l last_status $status
    set -l elapsed $CMD_DURATION
    set -l suffix "ms"
    if test $elapsed -gt 1000
        set elapsed (math $elapsed / 1000)
        set suffix "s"
    end
    
    set -l color brblack
    if test $last_status -gt 0
        set color red
    end

    set_color $color
    echo -n -s 
    set_color --bold black -b $color
    if test $last_status -gt 0
        echo -n -s $last_status' '
    end
    set_color --bold black -b brblack
    if test $last_status -gt 0
        echo -n -s ' '
    end
    echo -n -s $elapsed$suffix' '
    set_color --bold black -b blue
    echo -n -s ' '$USER@$hostname
    set_color normal
    set_color blue
    echo -n -s 
    set_color normal
end