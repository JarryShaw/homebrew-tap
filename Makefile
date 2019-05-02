init:
	brew tap-new jarryshaw/tap
	curl -L -s \
	    https://www.gitignore.io/api/macos,ruby,visualstudiocode,python | sed s/^#Pipfile.lock/Pipfile.lock/ > .gitignore
	curl --output CODE_OF_CONDUCT.md \
	    https://github.com/Homebrew/homebrew-core/raw/master/CODE_OF_CONDUCT.md
	curl --output CONTRIBUTING.md \
	    https://github.com/Homebrew/homebrew-core/raw/master/CONTRIBUTING.md
	curl --output LICENSE.txt \
	    https://github.com/Homebrew/homebrew-core/raw/master/LICENSE.txt
	mkdir -p .github
	curl --output .github/PULL_REQUEST_TEMPLATE.md \
	    https://raw.githubusercontent.com/Homebrew/homebrew-core/master/.github/PULL_REQUEST_TEMPLATE.md
	curl --output .github/ISSUE_TEMPLATE.md \
	    https://raw.githubusercontent.com/Homebrew/homebrew-core/master/.github/ISSUE_TEMPLATE.md
	mkdir -p .github/ISSUE_TEMPLATE
	curl --output .github/ISSUE_TEMPLATE/Reproducible-Bug-Report.md \
	    https://raw.githubusercontent.com/Homebrew/homebrew-core/master/.github/ISSUE_TEMPLATE/Reproducible-Bug-Report.md

audit:
	$(MAKE) -CGenerator check

update:
	$(MAKE) -CGenerator fetch formula link
