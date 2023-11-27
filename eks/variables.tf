variable "region" {
    description = "aws region"
    type = string
}

variable "ssh-key" {
    description = "aws ssh-key"
    type = string
}

variable "eks_cluster_name" {
    description = "The name of the Amazon EKS cluster."
    type = string
}