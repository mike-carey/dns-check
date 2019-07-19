#!/usr/bin/env make

FLY_TARGET ?= concourse

PIPELINE_NAME ?= dns-check

.PHONY: *

.vars.yml:
	[[ -f .vars.yml ]] || echo "---\n{}\n" > .vars.yml

pipeline: .vars.yml
	fly -t $(FLY_TARGET) sp -p $(PIPELINE_NAME) -c pipeline.yml -l vars.yml -l .vars.yml
