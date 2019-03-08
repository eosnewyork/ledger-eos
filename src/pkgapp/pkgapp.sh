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
APP_DIR=$(cd ${SCRIPT_DIR}/../eos-app && pwd)
PKG_DIR=$(cd ${SCRIPT_DIR}/../../pkgapp && pwd)

# Copy hex file
cp ${APP_DIR}/bin/app.hex ${PKG_DIR}/app.hex

APPNAME=$1
APPVERSION=$2
ICONNAME=$3

TARGET_ID=0x31100004
DATASIZE=$(cat ${APP_DIR}/debug/app.map |grep _nvram_data_size | tr -s ' ' | cut -f2 -d' ')
ICONHEX=$(python ${BOLOS_SDK}/icon.py ${APP_DIR}/${ICONNAME} hexbitmaponly)

cat >${PKG_DIR}/loadapp.sh <<'EOL'
#!/usr/bin/env bash
if command -v python3 &>/dev/null; then
    echo Python 3 detected
else
    echo Python 3 is required
    exit 1
fi

#Create temporary venv
INSTALL_SCRIPT_DIR=$(cd $(dirname $0) && pwd)
python3 -m venv ${INSTALL_SCRIPT_DIR}/temp
source ${INSTALL_SCRIPT_DIR}/temp/bin/activate

#Install python dependencies
pip3 install -U setuptools ledgerblue

# Run installation script
python3 -m ledgerblue.loadApp --appFlags 0x40 --tlv --targetId 0x31100004 --delete --fileName ${INSTALL_SCRIPT_DIR}/app.hex --appName EosDemo --appVersion 0.0.0 --icon 0100000000ffffff00ffffffffffff7ffebffddffbeff7eff7d7ebb7edb7ed6ff61ff8ffffffffffff --dataSize 0x00000040
EOL

chmod +x ${PKG_DIR}/loadapp.sh
