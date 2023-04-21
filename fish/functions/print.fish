function print -a text -a color -a bg_color
    if test $bg_color
        set_color $color --bold -b $bg_color
    else
        set_color $color --bold
    end
    echo -n -s ' '$text' '
    set_color normal
end
