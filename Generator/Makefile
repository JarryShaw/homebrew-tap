.PHONY: all brew fetch style pipenv formula

export PIPENV_VENV_IN_PROJECT=1

all: brew pipenv formula style
check: brew-style-tap brew-audit-tap
pipenv: pipenv-update

brew: brew-update
style: brew-style

link: bpython2 bpython3 nlohmann_json poet2 poet3 ptpython2 ptpython3
fetch: nlohmann-json noob ssh-askpass uti
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
	brew audit --fix --new-formula jarryshaw/tap/$(FORMULA) || true

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

bpython2:
	ln -sf ../Formula/bpython@2.rb ../Aliases/bpython2

bpython3:
	ln -sf ../Formula/bpython.rb ../Aliases/bpython3
	ln -sf ../Formula/bpython.rb ../Aliases/bpython@3

bro-pkg:
	pipenv run python bro-pkg.py
	FORMULA="bro-pkg" $(MAKE) brew-audit

nlohmann-json:
	pipenv run python nlohmann-json.py
	FORMULA="nlohmann-json" $(MAKE) brew-audit

nlohmann_json:
	ln -sf ../Formula/nlohmann-json.rb ../Aliases/nlohmann_json

noob:
	pipenv run python noob.py
	FORMULA="noob" $(MAKE) brew-audit

poet2:
	ln -sf ../Formula/poet@2.rb ../Aliases/poet2

poet3:
	ln -sf ../Formula/poet.rb ../Aliases/poet3
	ln -sf ../Formula/poet.rb ../Aliases/poet@3

ptpython2:
	ln -sf ../Formula/ptpython@2.rb ../Aliases/ptpython2

ptpython3:
	ln -sf ../Formula/ptpython.rb ../Aliases/ptpython3
	ln -sf ../Formula/ptpython.rb ../Aliases/ptpython@3

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
	pipenv run python uti.py
	FORMULA="uti" $(MAKE) brew-audit

vermin:
	pipenv run python vermin.py
	FORMULA="vermin" $(MAKE) brew-audit
