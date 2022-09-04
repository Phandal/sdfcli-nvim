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
	./utils/stylua --config-path stylua.toml --glob 'lua/**/*.lua' -- lua
	luacheck --no-color -q lua
	vusted lua

.PHONY: integration
integration:
	./utils/stylua --config-path stylua.toml --check --glob 'lua/**/*.lua' -- lua
	luacheck --no-color -q lua
	vusted lua

