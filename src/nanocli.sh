#!/usr/bin/env bash
#*******************************************************************************
#*   (c) 2019 ZondaX GmbH
#*
#*  Licensed under the Apache License, Version 2.0 (the "License");
#*  you may not use this file except in compliance with the License.
#*  You may obtain a copy of the License at
#*
#*      http://www.apache.org/licenses/LICENSE-2.0
#*
#*  Unless required by applicable law or agreed to in writing, software
#*  distributed under the License is distributed on an "AS IS" BASIS,
#*  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#*  See the License for the specific language governing permissions and
#*  limitations under the License.
#********************************************************************************

SCRIPT_DIR=$(cd $(dirname $0) && pwd)

handle_config()
{
    os_string="$(uname -s)"
    case "${os_string}" in
        Linux*)
            sudo apt-get install libusb-1.0.0 libudev-dev
            pip install -U setuptools
            pip install -U --no-cache ledgerblue ecpy
            ;;
        Darwin*)
            brew install libusb
            pip install -U ledgerblue ecpy
            ;;
        *)
            echo "OS not recognized"
            ;;
    esac

}

handle_make()
{
    # This function works in the scope of the container
    DOCKER_IMAGE=zondax/ledger-docker-bolos
    BOLOS_SDK=/project/deps/nanos-secure-sdk
    BOLOS_ENV=/opt/bolos

    docker run -i --rm \
            -e BOLOS_SDK=${BOLOS_SDK} \
            -e BOLOS_ENV=${BOLOS_ENV} \
            -u $(id -u) \
            -v $(pwd):/project \
            ${DOCKER_IMAGE} \
            make -C /project/src/eos-app $1
}

handle_load()
{
    # This function works in the scope of the host
    export BOLOS_SDK=${SCRIPT_DIR}/deps/nanos-secure-sdk
    export BOLOS_ENV=/opt/bolos
    make -C ${SCRIPT_DIR}/src/eos-app load
}

handle_delete()
{
    # This function works in the scope of the host
    export BOLOS_SDK=${SCRIPT_DIR}/deps/nanos-secure-sdk
    export BOLOS_ENV=/opt/bolos
    make -C ${SCRIPT_DIR}/src/eos-app delete
}

case "$1" in
    config)     handle_config;;
    make)       handle_make $2;;
    load)       handle_load;;
    delete)     handle_delete;;
    *)
        echo "ERROR. Valid commands: exec, make, config, ca, load, delete"
        ;;
esac
