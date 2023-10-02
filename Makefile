.PHONY: all clean sync test

sync:
	git add .
	git commit -m "nvim updates"
	git push origin head
	cd /Users/integralist/Code/shell/dotfiles/.config/nvim
	git pull --rebase origin
	cd ../
	git commit -m "bump nvim"
	git push origin head
	cd /Users/integralist/.config/nvim
