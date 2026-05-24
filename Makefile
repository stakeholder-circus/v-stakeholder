V ?= v
BIN := bin/stakeholder
SRC := src/main.v

.PHONY: all compiler-proof fmt-check build test clean

all: build

compiler-proof:
	$(V) version

fmt-check:
	$(V) fmt -verify $(SRC)

build:
	mkdir -p bin
	$(V) -gc none -o $(BIN) $(SRC)

test: fmt-check build
	BIN=$(BIN) tests/test_cli.sh

clean:
	rm -rf bin
