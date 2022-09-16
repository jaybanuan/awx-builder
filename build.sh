#!/bin/bash -x

AWX_BRANCH=$1

test -n "${AWX_BRANCH}" || {
    echo "The variable 'AWX_BRANCH' must be specified. 21.5.0, 21.4.0, 21.3.0, 21.2.0" >&2
    exit 1
}

git clone -b $AWX_BRANCH https://github.com/ansible/awx.git awx-${AWX_BRANCH}

pip3 install docker-compose ansible #"setuptools_scm[toml]"

(
    echo "----- build -------------------------------------------------------- "

    cd awx-${AWX_BRANCH}

    export PYTHON=python3
    export VENV_BASE=$(pwd)/venv_base

#    make virtualenv #requirements_dev
    make SHELL=/bin/bash docker-compose-build
#    python3 -m venv venv
#    source venv/bin/activate
#    pip3 install docker-compose ansible

)
