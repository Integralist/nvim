.PHONY: all clean sync test # 1

sync:
	git add .
	git commit -m "nvim updates"
	git push origin head
	cd /Users/integralist/Code/shell/dotfiles/.config/nvim
	git pull --rebase origin main
	cd /Users/integralist/Code/shell/dotfiles
	git add .
	git commit -m "bump nvim"
	git push origin head
	cd /Users/integralist/.config/nvim
