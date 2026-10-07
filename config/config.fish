if status is-interactive

    function fish_title
            printf 'Terminal'
    end
        
    function toggle-plasma-panel
        qdbus org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.evaluateScript \
            'panelById(28).hiding = panelById(28).hiding == "autohide" ? "none" : "autohide"' >/dev/null
    end
        
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

	alias clear="printf '\033c'"
    alias toggle_panel='toggle-plasma-panel'
end

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

