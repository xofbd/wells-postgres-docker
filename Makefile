.PHONY: all
all: clean docker-run

include make/data.mk
-include make/docker.mk
