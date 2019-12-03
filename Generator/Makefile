.PHONY: all brew fetch style pipenv formula

export PIPENV_VENV_IN_PROJECT=1

all: brew pipenv link fetch formula style
check: brew-style-tap brew-audit-tap
pipenv: pipenv-update

brew: brew-update
style: brew-style

link: bpython2 bpython3 nlohmann_json poet2 poet3 ptpython2 ptpython3 sass
fetch: dart dart-sass pyinstaller nlohmann-json ssh-askpass uti
formula: appdmg basher dmgbuild f2format git-hg macdaily node-sass noob poseur sloc sphinx vermin walrus

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
	pipenv run pip install -U pip setuptools wheel
	while true; do \
		pipenv update && break ; \
	done
	pipenv install --dev
	pipenv clean

pipenv-remove:
	pipenv --rm

appdmg: pipenv
	pipenv run python scripts/appdmg.py
	FORMULA="appdmg" $(MAKE) brew-audit

basher: pipenv
	pipenv run python scripts/basher.py
	FORMULA="basher" $(MAKE) brew-audit

bpython2:
	ln -sf ../Formula/bpython@2.rb ../Aliases/bpython2

bpython3:
	ln -sf ../Formula/bpython.rb ../Aliases/bpython3
	ln -sf ../Formula/bpython.rb ../Aliases/bpython@3

bro-pkg: pipenv
	pipenv run python scripts/bro-pkg.py
	FORMULA="bro-pkg" $(MAKE) brew-audit

dart: brew
	pipenv run python scripts/dart.py
	FORMULA="dart" $(MAKE) brew-audit

dart-sass: brew
	pipenv run python scripts/dart-sass.py
	FORMULA="dart-sass" $(MAKE) brew-audit

dmgbuild: pipenv
	pipenv run python scripts/dmgbuild.py
	FORMULA="dmgbuild" $(MAKE) brew-audit

f2format: pipenv
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

macdaily: pipenv
	pipenv run python scripts/macdaily.py
	FORMULA="macdaily" $(MAKE) brew-audit

nlohmann-json: brew
	pipenv run python scripts/nlohmann-json.py
	FORMULA="nlohmann-json" $(MAKE) brew-audit

nlohmann_json:
	ln -sf ../Formula/nlohmann-json.rb ../Aliases/nlohmann_json

node-sass: brew
	pipenv run python scripts/node-sass.py
	FORMULA="node-sass" $(MAKE) brew-audit

noob: pipenv
	pipenv run python scripts/noob.py
	FORMULA="noob" $(MAKE) brew-audit

poet2:
	ln -sf ../Formula/poet@2.rb ../Aliases/poet2

poet3:
	ln -sf ../Formula/poet.rb ../Aliases/poet3
	ln -sf ../Formula/poet.rb ../Aliases/poet@3

poseur: pipenv
	pipenv run python scripts/poseur.py
	FORMULA="poseur" $(MAKE) brew-audit

ptpython2:
	ln -sf ../Formula/ptpython@2.rb ../Aliases/ptpython2

ptpython3:
	ln -sf ../Formula/ptpython.rb ../Aliases/ptpython3
	ln -sf ../Formula/ptpython.rb ../Aliases/ptpython@3

pyinstaller: brew
	pipenv run python scripts/pyinstaller.py
	FORMULA="pyinstaller" $(MAKE) brew-audit

sass:
	ln -sf ../Formula/dart-sass.rb ../Aliases/sass

sloc: brew
	pipenv run python scripts/sloc.py
	FORMULA="sloc" $(MAKE) brew-audit

sphinx: brew pipenv
	pipenv run python scripts/sphinx.py
	FORMULA="sphinx" $(MAKE) brew-audit

ssh-askpass:
	pipenv run python scripts/ssh-askpass.py
	FORMULA="ssh-askpass" $(MAKE) brew-audit

uti:
	pipenv run python scripts/uti.py
	FORMULA="uti" $(MAKE) brew-audit

vermin: pipenv
	pipenv run python scripts/vermin.py
	FORMULA="vermin" $(MAKE) brew-audit

walrus: pipenv
	pipenv run python scripts/walrus.py
	FORMULA="walrus" $(MAKE) brew-audit
