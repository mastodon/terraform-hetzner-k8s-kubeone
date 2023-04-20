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

output "kubeone_api" {
  description = "kube-apiserver LB endpoint"

  value = {
    endpoint                    = local.kubeapi_endpoint
    apiserver_alternative_names = var.apiserver_alternative_names
  }
}

output "ssh_commands" {
  value = formatlist("ssh ${var.ssh_username}@%s", hcloud_server.control_plane.*.ipv4_address)
}

output "kubeone_hosts" {
  description = "Control plane endpoints to SSH to"

  value = {
    control_plane = {
      hostnames            = hcloud_server.control_plane.*.name
      cluster_name         = var.cluster_name
      cloud_provider       = "hetzner"
      private_address      = hcloud_server_network.control_plane.*.ip
      public_address       = hcloud_server.control_plane.*.ipv4_address
      network_id           = hcloud_network.net.id
      ssh_agent_socket     = var.ssh_agent_socket
      ssh_port             = var.ssh_port
      ssh_user             = var.ssh_username
    }
  }
}
