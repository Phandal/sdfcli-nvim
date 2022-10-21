.PHONY: all
all: fmt lint test

.PHONY: fmt
fmt:
	stylua --config-path stylua.toml --glob 'lua/**/*.lua' -- lua

.PHONY: lint
lint:
	luacheck --no-color -q ./lua

.PHONY: test
test:
	vusted tests/
#.PHONY: test
#test:
#	nvim --headless -c "PlenaryBustedDirectory tests/"

.PHONY: pre-commit
pre-commit:
	stylua --config-path stylua.toml --glob 'lua/**/*.lua' -- lua
	luacheck --no-color -q lua
	vusted tests/

.PHONY: integration
integration:
	stylua --config-path stylua.toml --check --glob 'lua/**/*.lua' -- lua
	luacheck --no-color -q lua
	vusted tests/

