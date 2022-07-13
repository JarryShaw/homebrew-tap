.PHONY: core git-hg nlohmann-json noob ssh-askpass uti

all: core git-hg nlohmann-json noob ssh-askpass uti

config:
	git -C jarryshaw-core remote add upstream https://github.com/homebrew/homebrew-core.git

sync:
	git -C jarryshaw-core checkout master
	git -C jarryshaw-core pull upstream master
	git -C jarryshaw-core push origin master

core:
	git submodule add -f https://github.com/JarryShaw/homebrew-core.git jarryshaw-core

git-hg:
	git submodule add -f https://github.com/cosmin/git-hg.git cosmin-git-hg

nlohmann-json:
	git submodule add -f https://github.com/nlohmann/homebrew-json.git nlohmann-json

noob:
	git submodule add -f https://github.com/zmwangx/homebrew-npm-noob.git zmwangx-npm-noob

ssh-askpass:
	git submodule add -f https://github.com/theseal/homebrew-ssh-askpass.git theseal-ssh-askpass

uti:
	git submodule add -f https://github.com/alexaubry/homebrew-formulas.git alexaubry-formulas
