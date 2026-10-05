#!/usr/bin/env bash

set -euo pipefail

branch() {
    git branch --show-current
}

usage() {
    cat <<EOF
usage: $0 <command>

command:
  setorigin  set/replace origin
  info       repository information

  init       Initialize git repo  
  pull       Pull current branch with rebase
  push       Add, commit, and push changes
  save       Add and commit changes

  log        Show recent history
  status     Show repository status
  branches   Show branches
  
  discard    Discard unstaged changes
  undo       Undo last commit, keep changes staged
EOF
}

case "${1:-}" in
	init)
		git init
		;;

	setorigin)
	    if [[ $# -ne 2 ]]; then
	        echo "Usage: $0 setorigin <url>"
	        exit 1
	    fi

	    git remote get-url origin >/dev/null 2>&1 \
	        && git remote set-url origin "$2" \
	        || git remote add origin "$2"

	    echo "origin: $(git remote get-url origin)"
	    ;;

	info)
	    echo "Repository : $(basename "$(git rev-parse --show-toplevel)")"
	    echo "Root       : $(git rev-parse --show-toplevel)"
	    echo "Branch     : $(git branch --show-current)"
	    echo "Origin     : $(git remote get-url origin 2>/dev/null || echo "not set")"
	    echo "Commit     : $(git rev-parse --short HEAD)"
	    echo "Status     :"
	    git status --short
	    ;;

    push)
        git add .

        if git diff --cached --quiet; then
            echo "Nothing to commit."
        else
            git commit -m "$(date -uIseconds)"
        fi

        git push origin "$(branch)"
        ;;

    pull)
        git pull --rebase origin "$(branch)"
        ;;

    save)
        git add .

        if git diff --cached --quiet; then
            echo "Nothing to commit."
            exit 0
        fi

        git commit -m "$(date -uIseconds)"
        ;;

    status)
        git status --short --branch
        ;;

    log)
        git log --oneline --graph --decorate --all -20
        ;;

    branches)
        git branch -vv
        ;;

    undo)
        git reset --soft HEAD~1
        ;;

    discard)
        git restore .
        ;;

    *)
        usage
        exit 1
        ;;
esac
