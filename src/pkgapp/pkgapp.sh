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

cat >${PKG_DIR}/loadapp.sh <<EOL
#!/usr/bin/env bash
pip install -U setuptools ledgerblue

SCRIPT_DIR=\$(cd \$(dirname \$0) && pwd)
python -m ledgerblue.loadApp --appFlags 0x40 --tlv --targetId ${TARGET_ID} --delete --fileName \${SCRIPT_DIR}/app.hex --appName ${APPNAME} --appVersion ${APPVERSION} --icon ${ICONHEX} --dataSize ${DATASIZE}
EOL

chmod +x ${PKG_DIR}/loadapp.sh
