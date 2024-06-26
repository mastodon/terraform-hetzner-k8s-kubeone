/*
Copyright 2019 The KubeOne Authors.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

variable "cluster_name" {
  description = "prefix for cloud resources"
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$", var.cluster_name))
    error_message = "Value of cluster_name should be lowercase and can only contain alphanumeric characters and hyphens(-)."
  }
}

variable "apiserver_alternative_names" {
  description = "subject alternative names for the API Server signing cert."
  type        = list(string)
  default     = []
}

variable "worker_os" {
  description = "OS to run on worker machines"
  type        = string

  # valid choices are:
  # * ubuntu
  # * centos
  # * rockylinux
  default = "ubuntu"
}

variable "ssh_keys" {
  description = "List of SSH keys that will have access to the server. If none are given, existing SSH keys in Hetzner will be used."
  type        = list(string)
  default     = []
}

variable "ssh_key_selector" {
  description = "Selector to use when automatically pulling existing SSH keys."
  type        = string
  default     = "role=admin"
}

variable "ssh_port" {
  description = "SSH port to be used to provision instances"
  type        = number
  default     = 22
}

variable "ssh_username" {
  description = "SSH user, used only in output"
  type        = string
  default     = "root"
}

variable "ssh_agent_socket" {
  description = "SSH Agent socket, default to grab from $SSH_AUTH_SOCK"
  type        = string
  default     = "env:SSH_AUTH_SOCK"
}

variable "disable_kubeapi_loadbalancer" {
  description = "E2E tests specific variable to disable usage of any loadbalancer in front of kubeapi-server"
  type        = bool
  default     = false
}

# Provider specific settings

variable "control_plane_type" {
  default = "cx22"
  type    = string
}

variable "control_plane_replicas" {
  default = 3
  type    = number
}

variable "control_plane_datacenters" {
  default = ["fsn1", "nbg1", "hel1"]
  type = list(string)
}

variable "worker_type" {
  default = "cx22"
  type    = string
}

variable "lb_type" {
  default = "lb11"
  type    = string
}

variable "datacenter" {
  default = "nbg1"
  type    = string
}

variable "image" {
  default = "ubuntu-20.04"
  type    = string
}

variable "ip_range" {
  description = "ip range to use for private network"
  type        = string
  default     = "192.168.0.0/16"
}

variable "ip_range_cloud" {
  description = "ip range to use for the cloud instances"
  type        = string
  default     = "192.168.0.0/17"
}

variable "control_plane_source_ips" {
  description = "List of IPs that are allowed to connect to the control instances"
  type        = list(string)
}

variable "network_zone" {
  description = "network zone to use for private network"
  type        = string
  default     = "eu-central"
}

variable "initial_machinedeployment_operating_system_profile" {
  description = <<EOF
Name of operating system profile for MachineDeployments, only applicable if operating-system-manager addon is enabled.
If not specified, the default value will be added by machine-controller addon.
EOF
  type        = string
  default     = ""
}
