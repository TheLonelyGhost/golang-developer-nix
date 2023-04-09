NIX := nix

ifndef STATIX
STATIX := $(NIX) run nixpkgs\#statix --
endif

.PHONY: test

test:
	$(STATIX) check
	$(NIX) flake check
	$(NIX) build '.#cobra-cli' && rm -f ./result
