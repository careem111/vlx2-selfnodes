
data "aws_eks_cluster" "vlx-eks" {
  name = var.eks_cluster_name
}




module "eks_self_managed_node_group" {
  source = "github.com/aws-samples/amazon-eks-self-managed-node-group"
  
 
  #"github.com/careem111/amazon-eks-self-managed-node-group-modules//modules/eks?ref=v0.1"

  eks_cluster_name = var.eks_cluster_name
  instance_type    = "t3.medium"
  desired_capacity = 3
  min_size         = 2
  max_size         = 3
  subnets          = data.aws_eks_cluster.vlx-eks.vpc_config[0].subnet_ids
  #subnets called from the already created eks_cluster
  # refer to https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster
  key_name = var.ssh-key

  node_labels = {
      "node.kubernetes.io/node-group" = "node-group-a"
  }

  # Outposts require that you encrypt all EBS volumes
  ebs_encrypted   = true
}

