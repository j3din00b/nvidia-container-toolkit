/**
# Copyright (c) 2022, NVIDIA CORPORATION.  All rights reserved.
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
**/

package config

import (
	"github.com/pelletier/go-toml"
)

// CLIConfig stores the options for the nvidia-container-cli
type CLIConfig struct {
	Root string
}

// getCLIConfigFrom reads the nvidia container runtime config from the specified toml Tree.
func getCLIConfigFrom(toml *toml.Tree) *CLIConfig {
	cfg := getDefaultCLIConfig()

	if toml == nil {
		return cfg
	}

	cfg.Root = toml.GetDefault("nvidia-container-cli.root", cfg.Root).(string)

	return cfg
}

// getDefaultCLIConfig defines the default values for the config
func getDefaultCLIConfig() *CLIConfig {
	c := CLIConfig{
		Root: "",
	}

	return &c
}
