# Mastodon Terraform - Hetzner KubeOne Cluster

Terraform module for creating a Kubernetes cluster in Hetzner using KubeOne.

As Hetzner doesn't have a managed Kubernetes service, this module sets up a cluster to be compatible with [KubeOne](https://github.com/kubermatic/kubeone) as the cluster manager.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.8.0 |
| <a name="requirement_hcloud"></a> [hcloud](#requirement\_hcloud) | ~> 1.47.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_hcloud"></a> [hcloud](#provider\_hcloud) | ~> 1.47.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [hcloud_firewall.cluster](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/firewall) | resource |
| [hcloud_load_balancer.load_balancer](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/load_balancer) | resource |
| [hcloud_load_balancer_network.load_balancer](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/load_balancer_network) | resource |
| [hcloud_load_balancer_service.load_balancer_service](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/load_balancer_service) | resource |
| [hcloud_load_balancer_target.load_balancer_target](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/load_balancer_target) | resource |
| [hcloud_network.net](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/network) | resource |
| [hcloud_network_subnet.kubeone](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/network_subnet) | resource |
| [hcloud_placement_group.control_plane](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/placement_group) | resource |
| [hcloud_server.control_plane](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/server) | resource |
| [hcloud_server_network.control_plane](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/server_network) | resource |
| [hcloud_ssh_keys.admin_keys](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/data-sources/ssh_keys) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_apiserver_alternative_names"></a> [apiserver\_alternative\_names](#input\_apiserver\_alternative\_names) | subject alternative names for the API Server signing cert. | `list(string)` | `[]` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | prefix for cloud resources | `string` | n/a | yes |
| <a name="input_control_plane_datacenters"></a> [control\_plane\_datacenters](#input\_control\_plane\_datacenters) | n/a | `list(string)` | <pre>[<br>  "fsn1",<br>  "nbg1",<br>  "hel1"<br>]</pre> | no |
| <a name="input_control_plane_replicas"></a> [control\_plane\_replicas](#input\_control\_plane\_replicas) | n/a | `number` | `3` | no |
| <a name="input_control_plane_source_ips"></a> [control\_plane\_source\_ips](#input\_control\_plane\_source\_ips) | List of IPs that are allowed to connect to the control instances | `list(string)` | n/a | yes |
| <a name="input_control_plane_type"></a> [control\_plane\_type](#input\_control\_plane\_type) | n/a | `string` | `"cx22"` | no |
| <a name="input_datacenter"></a> [datacenter](#input\_datacenter) | n/a | `string` | `"nbg1"` | no |
| <a name="input_disable_kubeapi_loadbalancer"></a> [disable\_kubeapi\_loadbalancer](#input\_disable\_kubeapi\_loadbalancer) | E2E tests specific variable to disable usage of any loadbalancer in front of kubeapi-server | `bool` | `false` | no |
| <a name="input_image"></a> [image](#input\_image) | n/a | `string` | `"ubuntu-20.04"` | no |
| <a name="input_initial_machinedeployment_operating_system_profile"></a> [initial\_machinedeployment\_operating\_system\_profile](#input\_initial\_machinedeployment\_operating\_system\_profile) | Name of operating system profile for MachineDeployments, only applicable if operating-system-manager addon is enabled.<br>If not specified, the default value will be added by machine-controller addon. | `string` | `""` | no |
| <a name="input_ip_range"></a> [ip\_range](#input\_ip\_range) | ip range to use for private network | `string` | `"192.168.0.0/16"` | no |
| <a name="input_ip_range_cloud"></a> [ip\_range\_cloud](#input\_ip\_range\_cloud) | ip range to use for the cloud instances | `string` | `"192.168.0.0/17"` | no |
| <a name="input_lb_type"></a> [lb\_type](#input\_lb\_type) | n/a | `string` | `"lb11"` | no |
| <a name="input_network_zone"></a> [network\_zone](#input\_network\_zone) | network zone to use for private network | `string` | `"eu-central"` | no |
| <a name="input_ssh_agent_socket"></a> [ssh\_agent\_socket](#input\_ssh\_agent\_socket) | SSH Agent socket, default to grab from $SSH\_AUTH\_SOCK | `string` | `"env:SSH_AUTH_SOCK"` | no |
| <a name="input_ssh_key_selector"></a> [ssh\_key\_selector](#input\_ssh\_key\_selector) | Selector to use when automatically pulling existing SSH keys. | `string` | `"role=admin"` | no |
| <a name="input_ssh_keys"></a> [ssh\_keys](#input\_ssh\_keys) | List of SSH keys that will have access to the server. If none are given, existing SSH keys in Hetzner will be used. | `list(string)` | `[]` | no |
| <a name="input_ssh_port"></a> [ssh\_port](#input\_ssh\_port) | SSH port to be used to provision instances | `number` | `22` | no |
| <a name="input_ssh_username"></a> [ssh\_username](#input\_ssh\_username) | SSH user, used only in output | `string` | `"root"` | no |
| <a name="input_worker_os"></a> [worker\_os](#input\_worker\_os) | OS to run on worker machines | `string` | `"ubuntu"` | no |
| <a name="input_worker_type"></a> [worker\_type](#input\_worker\_type) | n/a | `string` | `"cx22"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_kubeone_api"></a> [kubeone\_api](#output\_kubeone\_api) | kube-apiserver LB endpoint |
| <a name="output_kubeone_hosts"></a> [kubeone\_hosts](#output\_kubeone\_hosts) | Control plane endpoints to SSH to |
| <a name="output_ssh_commands"></a> [ssh\_commands](#output\_ssh\_commands) | n/a |
