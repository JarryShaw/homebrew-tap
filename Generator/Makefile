.PHONY: all brew pipenv

all: brew pipenv all-formula
brew: brew-update
pipenv: pipenv-update
all-formula: sloc sphinx ssh-askpass uti vermin

brew-update:
	brew update

brew-upgrade:
	brew upgrade

brew-cleanup:
	brew cleanup

pipenv-update:
	pipenv update
	pipenv install --dev
	pipenv clean

pipenv-remove:
	pipenv --rm

.ONESHELL:
noob:
	cd ../Formula
	wget https://raw.githubusercontent.com/zmwangx/homebrew-npm-noob/master/Formula/noob.rb

sloc:
	pipenv run python sloc.py

sphinx:
	pipenv run python sphinx.py

.ONESHELL:
ssh-askpass:
	cd ../Formula
	wget https://raw.githubusercontent.com/theseal/homebrew-ssh-askpass/master/Formula/ssh-askpass.rb

.ONESHELL:
uti:
	cd ../Formula
	wget https://raw.githubusercontent.com/alexaubry/homebrew-formulas/master/Formula/uti.rb

vermin:
	pipenv run python vermin.py
