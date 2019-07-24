restow() {
	# keyboard layouts can't be symlinked
	cd ~/dotfiles || return 1
	stow --ignore="Keyboard Layouts" -Rvt ~/ remap terminal editing
	cp -Rf ~/dotfiles/remap/Library/"Keyboard Layouts"/ColemakDH-ansi.bundle \
	   ~/Library/"Keyboard Layouts"
}

unstow() {
	cd ~/dotfiles || return 1
	stow --ignore="Keyboard Layouts" -Dvt ~/ remap terminal editing
}
