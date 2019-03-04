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

.PHONY: all deps build clean load delete

all: build

deps:
	@echo "Install dependencies"
	$(CURDIR)/src/nanocli.sh config

build:
	$(CURDIR)/src/nanocli.sh make

clean:
	$(CURDIR)/src/nanocli.sh make clean

load:
	$(CURDIR)/src/nanocli.sh make load

delete:
	$(CURDIR)/src/nanocli.sh make delete

package:
	@echo "Run packaging makefile"
	make -C ${CURDIR}/src/pkgapp
