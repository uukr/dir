if status is-interactive
	alias clear="printf '\033c'"

	function fish_greeting
	end

	function fish_prompt
		set_color green
		
		if test $PWD = $HOME
			printf '$ '
		else
			set_color yellow
			printf '%s' (basename $PWD)
			set_color green
			printf ': '
		end
		set_color normal
	end

end

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
