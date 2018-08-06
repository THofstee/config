# set fish_plugins emacs

function fish_prompt
  # make a neat gradient for the directories on our working directory
  set colors 222 444 666 888 aaa
  set dirs (prompt_pwd | string split "/")
  set num_dirs (count $dirs)

  for x in (seq $num_dirs)
    set col_idx (math (count $colors) - (math $num_dirs - $x))
    if test $col_idx -lt 1
      set col_idx 1
    end

    set_color -o $colors[$col_idx]
    printf '%s' $dirs[$x]

    if test $x -lt $num_dirs
      printf '/'
    end

    set_color normal
  end

  # display git branch name if we are in a git work tree
  begin
    set temp (mktemp)
    set is_git (git rev-parse --is-inside-work-tree 2>&1 >$temp)
    if test $status -eq 0
      set_color $colors[(math (count $colors) - 2)]
      printf ' %s' (git rev-parse --abbrev-ref HEAD)
    end
  end

  # visual separation between the prompt and user input
  set_color -o $colors[(count $colors)]
  printf ' · '

  set_color normal
end

alias ls="ls --group-directories-first --color=auto"