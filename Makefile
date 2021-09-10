.PHONY: all
all: clean docker-run

include make/data.mk
-include make/docker.mk

.PHONY: test
test:
	test/test-db
	test/test-read-only
