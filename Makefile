.PHONY: install

check: fmt lint

fmt: ## format code
	shfmt -w -s .

lint: ## run lint check
	shfmt -d -s .
	shellcheck $$(shfmt -f .)

install: ## install the setup
	@install/main.sh

fingerprint: ## generate SHA-256 fingerprint of the dotfiles
	@git ls-files | xargs -I {} sha256sum "{}" | cut -d " " -f 1 | sha256sum | cut -d " " -f 1

help:
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST) | sort
