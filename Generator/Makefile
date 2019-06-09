.PHONY: all brew fetch style pipenv formula

export PIPENV_VENV_IN_PROJECT=1

all: brew pipenv formula style
check: brew-style-tap brew-audit-tap
pipenv: pipenv-update

brew: brew-update
style: brew-style

link: bpython2 bpython3 nlohmann_json poet2 poet3 ptpython2 ptpython3
fetch: pyinstaller nlohmann-json noob ssh-askpass uti
formula: f2format git-hg macdaily sloc sphinx vermin

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
	pipenv run python scripts/bro-pkg.py
	FORMULA="bro-pkg" $(MAKE) brew-audit

f2format:
	pipenv run python scripts/f2format.py
	FORMULA="f2format" $(MAKE) brew-audit

git-hg:
	git submodule init ../Submodules/cosmin-git-hg
	git submodule update ../Submodules/cosmin-git-hg
	git checkout master
	git pull
	pipenv run python scripts/git-hg.py
	FORMULA="git-hg" $(MAKE) brew-audit
	git submodule deinit ../Submodules/cosmin-git-hg

macdaily:
	pipenv run python scripts/macdaily.py
	FORMULA="macdaily" $(MAKE) brew-audit

nlohmann-json:
	pipenv run python scripts/nlohmann-json.py
	FORMULA="nlohmann-json" $(MAKE) brew-audit

nlohmann_json:
	ln -sf ../Formula/nlohmann-json.rb ../Aliases/nlohmann_json

noob:
	pipenv run python scripts/noob.py
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
	pipenv run python scripts/pyinstaller.py
	FORMULA="pyinstaller" $(MAKE) brew-audit

sloc:
	pipenv run python scripts/sloc.py
	FORMULA="sloc" $(MAKE) brew-audit

sphinx:
	pipenv run python scripts/sphinx.py
	FORMULA="sphinx" $(MAKE) brew-audit

ssh-askpass:
	pipenv run python scripts/ssh-askpass.py
	FORMULA="ssh-askpass" $(MAKE) brew-audit

uti:
	pipenv run python scripts/uti.py
	FORMULA="uti" $(MAKE) brew-audit

vermin:
	pipenv run python scripts/vermin.py
	FORMULA="vermin" $(MAKE) brew-audit
