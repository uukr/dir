if status is-interactive
  alias clear="printf '\033c'"

  function fish_greeting    
  end
  
  function fish_prompt
    set_color green
    printf '%s' (whoami)

    if test $PWD = $HOME
      printf ': '
    else
      printf '('
      set_color yellow
      printf '%s' (basename $PWD)
      set_color green
      printf ')$ '
    end

    set_color normal
  end
end
