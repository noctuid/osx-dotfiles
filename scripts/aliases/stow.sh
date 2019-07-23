restow() {
	# keyboard layouts can't be symlinked
	cd ~/dotfiles && stow --ignore="Keyboard Layouts" -Rvt ~/ remap terminal
	cp -Rf ~/dotfiles/remap/Library/"Keyboard Layouts"/ColemakDH-ansi.bundle \
	   ~/Library/"Keyboard Layouts"
}

unstow() {
	cd ~/dotfiles && stow --ignore="Keyboard Layouts" -Dvt ~/ remap terminal
}
