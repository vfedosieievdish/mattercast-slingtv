#!/bin/sh

#
#    Copyright (c) 2021 Project CHIP Authors
#
#    Licensed under the Apache License, Version 2.0 (the "License");
#    you may not use this file except in compliance with the License.
#    You may obtain a copy of the License at
#
#        http://www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS,
#    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#    See the License for the specific language governing permissions and
#    limitations under the License.
#

set -e

# Print CHIP logs on stdout
dlogutil CHIP &

# Set the correct path for .gcda files
export GCOV_PREFIX=/mnt/chip
export GCOV_PREFIX_STRIP=5

# Install lighting Matter app
pkgcmd -i -t tpk -p /mnt/chip/org.tizen.matter.*/out/org.tizen.matter.*.tpk
# Launch lighting Matter app
app_launcher -s org.tizen.matter.example.lighting

# TEST: pair app using network commissioning
/mnt/chip/chip-tool pairing onnetwork 1 20202021
# TEST: turn on light
/mnt/chip/chip-tool onoff on 1 1
# TEST: turn off light
/mnt/chip/chip-tool onoff off 1 1
