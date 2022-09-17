##############################################################################
# Variables

export SHELL ?= /bin/bash
export PYTHON ?= python3


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
	git clone -b $(AWX_BRANCH_NAME) https://github.com/ansible/awx.git awx-$(AWX_BRANCH_NAME)


.PHONY: build
build: check_awx_branch_name
	pip3 install -U requests urllib3
	pip3 install docker-compose ansible "setuptools_scm[toml]"
	docker image ls
	$(MAKE) -C awx-${AWX_BRANCH_NAME} docker-compose-build
	docker image ls


.PHONY: up
up: check_awx_branch_name
	$(MAKE) -C awx-${AWX_BRANCH_NAME} docker-compose


.PHONY: build-ui
build-ui:
	docker exec tools_awx_1 make clean-ui ui-devel
	docker exec -ti tools_awx_1 awx-manage createsuperuser
