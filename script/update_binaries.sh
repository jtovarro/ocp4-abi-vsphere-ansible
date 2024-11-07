#/bin/bash

HAS_CURL="$(type "curl" &> /dev/null && echo true || echo false)"
OC_INSTALL_DIR="/usr/local/bin"
VERSION="$1"
OC_URL="https://mirror.openshift.com/pub/openshift-v4/clients/ocp/${VERSION}/openshift-client-linux-${VERSION}.tar.gz"
OPENSHIFT_INSTALL_URL="https://mirror.openshift.com/pub/openshift-v4/clients/ocp/${VERSION}/openshift-install-linux.tar.gz"

downloadclient() {
        curl --progress-bar -Ls ${OC_URL} | tar zxvf - -C ${OC_INSTALL_DIR}/ oc
        curl --progress-bar -Ls ${OPENSHIFT_INSTALL_URL} | tar zxvf - -C ${OC_INSTALL_DIR}/ openshift-install
        chmod +x ${OC_INSTALL_DIR}/{oc,openshift-install}
}

main() {

    if [ "$EUID" -ne 0 ]
    then echo "Please run as root"
    exit 1
    fi

    if [[ "${HAS_CURL}" == "false" ]] ;then
        echo "please install curl package"
        exit 1
    else
        downloadclient
    fi
}

main

