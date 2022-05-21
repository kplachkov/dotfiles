.PHONY: setup test install

check: fmt lint

setup: ## install required development utilities
	sudo snap install shellcheck
	sudo snap install shfmt

fmt: ## format code
	shfmt -w -s .

lint: ## run lint check
	shfmt -d -s .
	shellcheck $$(shfmt -f .)

install: ## install the setup
	install/main.sh

help:
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST) | sort
