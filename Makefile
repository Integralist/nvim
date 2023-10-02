.PHONY: all clean sync test

sync:
	git add .
	git commit -m "nvim updates"
	git push origin head
	cd /Users/integralist/Code/shell/dotfiles/.config/nvim
	pwd
	git checkout main
	git pull --rebase origin main
	git log --oneline
	cd /Users/integralist/Code/shell/dotfiles
	git status
	git add .
	git commit -m "bump nvim"
	git push origin head
	cd /Users/integralist/.config/nvim
