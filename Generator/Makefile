.PHONY: all brew fetch style pipenv formula

export PIPENV_VENV_IN_PROJECT=1

all: brew pipenv formula style
check: brew-style-tap brew-audit-tap
pipenv: pipenv-update

brew: brew-update
style: brew-style

fetch: nlohmann_json noob ssh-askpass uti
formula: pyinstaller sloc sphinx vermin

brew-update:
	brew update

brew-upgrade:
	brew upgrade

brew-cleanup:
	brew cleanup

brew-audit: brew-audit-formula

brew-audit-tap:
	for file in $$( ls ../Formula/*.rb ) ; do \
		formula=$$( basename -s ".rb" $${file} ) ; \
		echo "+ brew audit --fix --new-formula jarryshaw/tap/$${formula}" ; \
		brew audit --fix --new-formula jarryshaw/tap/$${formula} ; \
	done

brew-audit-formula:
	brew audit --fix --new-formula jarryshaw/tap/$(FORMULA)

brew-style:	brew-style-formula

brew-style-tap:
	brew style --fix jarryshaw/tap

brew-style-formula:
	brew style --fix jarryshaw/tap/$(FORMULA)

pipenv-update:
	pipenv update
	pipenv install --dev
	pipenv clean

pipenv-remove:
	pipenv --rm

bro-pkg:
	pipenv run python bro-pkg.py
	FORMULA="bro-pkg" $(MAKE) brew-audit

nlohmann_json:
	curl --output ../Formula/nlohmann_json.rb \
	    https://raw.githubusercontent.com/nlohmann/homebrew-json/master/nlohmann_json.rb
	FORMULA="nlohmann_json" $(MAKE) brew-audit

noob:
	curl --output ../Formula/noob.rb \
		https://raw.githubusercontent.com/zmwangx/homebrew-npm-noob/master/Formula/noob.rb
	FORMULA="noob" $(MAKE) brew-audit

pyinstaller:
	pipenv run python pyinstaller.py
	FORMULA="pyinstaller" $(MAKE) brew-audit

sloc:
	pipenv run python sloc.py
	FORMULA="sloc" $(MAKE) brew-audit

sphinx:
	pipenv run python sphinx.py
	FORMULA="sphinx" $(MAKE) brew-audit

ssh-askpass:
	curl --output ../Formula/ssh-askpass.rb \
		https://raw.githubusercontent.com/theseal/homebrew-ssh-askpass/master/Formula/ssh-askpass.rb
	FORMULA="ssh-askpass" $(MAKE) brew-audit

uti:
	curl --output ../Formula/uti.rb \
		https://raw.githubusercontent.com/alexaubry/homebrew-formulas/master/Formula/uti.rb
	FORMULA="uti" $(MAKE) brew-audit

vermin:
	pipenv run python vermin.py
	FORMULA="vermin" $(MAKE) brew-audit
