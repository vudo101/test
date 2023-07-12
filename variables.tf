################ VPC ########################
variable "cidr_block" {
  type = string
  default = "10.120.96.0/22"
}

variable "cidr_block_subnet_1" {
    type = string
    default = "10.120.96.0/24"
}

variable "cidr_block_subnet_2" {
    type = string
    default = "10.120.97.0/24"
}

variable "availability_zone_1" {
    type = string
    default = "ap-southeast-2a"
}

variable "availability_zone_2" {
    type = string
    default = "ap-southeast-2c"
}

variable "tag_vpc" {
    type = string
    default = "vpc-syslog"
}

variable "tag_subnet_1" {
    type = string
    default = "subnet for vpc syslog"
}

variable "tag_subnet_2" {
    type = string
    default = "subnet for vpc syslog"
}

################# LaunchTempLate ##################

variable "autoscaling_group_name" {
    type = string
    default = "syslog-autoscaling-group"
}

variable "launch_config_name" {
    type = string
    default = "SysLog_launch_config"
}

variable "ami_id" {
    type = string
    default = "ami-07620139298af599e"
}

variable "default_security_group_id" {
    type        = string
    default     = "vpc-0a9e823c57307618d"
  }

variable "instance_type" {
    type = string
    default = "t3.medium"
}

################ AutoScalingGroup ##################

variable "desired_capacity" {
    type = number
    default = 2
}

variable "auto_scaling_group_name" {
    type = string
    default = "auto-scaling-group"
}

variable "subnet_ids" {
    description = "Subnet ids on private subnets"
    type        = list(string)
    default     = ["subnet-02a1207ec4256f2e9", "subnet-03c156f8911bde850"]
}

variable "tag_autoscaling_group_key" {
    type = string
    default = "ASG-Syslog"
}

variable "tag_autoscaling_group_value" {
    type = string
    default = "ASG-SysLog"
}

variable "min_size" {
    type = number
    default = 1
}

variable "max_size" {
    type = number
    default = 2
}

variable "desired_size" {
    type = number
    default = 2
}

################ NLB ###########################

variable "nlb_name" {
    type = string
    default = "Syslog-Networklb"
}

variable "subnets" {
    type    = list(string)
    default = ["subnet-02a1207ec4256f2e9", "subnet-03c156f8911bde850"]
}

variable "tag_alb" {
    type = string
    default = "Networklb"
}

################## TargetGroup ########################

variable "target_group_name" {
    type = string
    default = "target-group-syslog"
}

variable "target_group_port" {
    type = number
    default = 514
}

variable "target_group_protocol" {
    type = string
    default = "TCP"
}

################ Listener ######################

variable "listener_port" {
    type = number
    default = 514
}

variable "listener_protocol" {
    type = string
    default = "TCP"
}

variable "key_name" {
    type = string
    default = "syslog-instances-key"
}

variable "launch_template_name" {
    type = string
    default = "SysLog-LaunchTemplate"
}
