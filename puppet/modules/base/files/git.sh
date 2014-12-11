#!/bin/bash
#
function do_git {
    local GIT_REMOTE=$1
    local GIT_DEST=$2
    local GIT_REF=$3

    # Avoid git exiting when in some other dir than the typical /home/vagrant
    cd $(dirname $GIT_DEST)

    # check if the directory /home/vagrant/devstack exists
    if [[ ! -d $GIT_DEST ]]; then
        git clone $GIT_REMOTE $GIT_DEST
        cd $GIT_DEST
        # This checkout the branch stable/icehouse
        git checkout $GIT_REF
    fi

    cd $GIT_DEST
    git show --oneline | head -1
}


URL=${1:-https://github.com/openstack-dev/devstack}
LOCAL=${3:-/home/vagrant/devstack}
BRANCH=${2:-stable/icehouse}

set -o xtrace
set -o errexit

do_git $URL $LOCAL $BRANCH
