.PHONY: all clean sync test

sync:
	git add .
	git commit -m "nvim updates"
	git push origin head
	pushd -P /Users/integralist/Code/shell/dotfiles/.config/nvim # -P to resolve symlinks
	git pull --rebase origin
	pushd ../
	git commit -m "bump nvim"
	git push origin head
	popd # back to nvim folder in dotfile repo
	popd # back to nvim repo
