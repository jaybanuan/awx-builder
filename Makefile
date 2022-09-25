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


.PHONY: check_awx_branch_name
check_awx_branch_name:
	test -n "$(AWX_BRANCH_NAME)" || { \
		echo "The variable 'AWX_BRANCH_NAME' must be specified."; \
		exit 1; \
	}


.PHONY: clone
clone: check_awx_branch_name
	git clone -b $(AWX_BRANCH_NAME) https://github.com/ansible/awx.git $(AWX_SRC_DIR)


.PHONY: build
build: check_awx_branch_name build-impl


.PHONY: build-ui
build-ui: build-ui-impl


.PHONY: up
up: check_awx_branch_name up-impl


.PHONY: down
down: check_awx_branch_name down-impl


.PHONY: start
start: check_awx_branch_name start-impl


.PHONY: stop
stop: check_awx_branch_name stop-impl
