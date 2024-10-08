#!/usr/bin/env bash

# Copyright (c) 2021-2022, NVIDIA CORPORATION.  All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# This script is used to build the packages for the components of the NVIDIA
# Container Stack. These include the nvidia-container-toolkit in this repository
# as well as the components included in the third_party folder.
# All required packages are generated in the specified dist folder.

set -e

SCRIPTS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )"/../scripts && pwd )"

source "${SCRIPTS_DIR}"/utils.sh

if [[ $# -gt 0 ]]; then
    targets=($*)
else
    targets=${all[@]}
fi

git submodule update --init
git submodule status

eval $(${SCRIPTS_DIR}/get-component-versions.sh)

export NVIDIA_CONTAINER_TOOLKIT_VERSION
export NVIDIA_CONTAINER_TOOLKIT_TAG

for target in ${targets[@]}; do
    "${SCRIPTS_DIR}/build-all-components.sh" "${target}"
done
