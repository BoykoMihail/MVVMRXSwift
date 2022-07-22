install:
	@type pod >/dev/null 2>&1 || brew install cocoapods
	pod install
