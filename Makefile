##############################################################################
# Variables

export SHELL ?= /bin/bash
export PYTHON ?= python3

AWX_ADMIN_USERNAME ?= awx
AWX_ADMIN_PASSWORD ?= awx

AWX_SRC_DIR := awx-$(AWX_BRANCH_NAME)


##############################################################################
# Include

AWX_INSTALLER_FLAG := $(shell test "$(shell printf "$(AWX_BRANCH_NAME)\n18.0.0" | sort -V | head -n 1)" != "18.0.0"; echo $$?)

ifeq ($(AWX_INSTALLER_FLAG),1)
include Makefile-since-18
else
include Makefile-before-18
endif


##############################################################################
# Targets

.PHONY: clean
clean:
	echo "do nothing."


.PHONY: check-awx-branch-name
check-awx-branch-name:
	test -n "$(AWX_BRANCH_NAME)" || { \
		echo "The variable 'AWX_BRANCH_NAME' must be specified."; \
		exit 1; \
	}


.PHONY: clone
clone: clone-awx clone-postprocess


.PHONY: clone-awx
clone-awx: check-awx-branch-name
	git clone -b $(AWX_BRANCH_NAME) https://github.com/ansible/awx.git $(AWX_SRC_DIR)


.PHONY: build
build: check-awx-branch-name build-impl


.PHONY: build-ui
build-ui: build-ui-impl


.PHONY: up
up: check-awx-branch-name up-impl


.PHONY: down
down: check-awx-branch-name down-impl


.PHONY: start
start: check-awx-branch-name start-impl


.PHONY: stop
stop: check-awx-branch-name stop-impl
