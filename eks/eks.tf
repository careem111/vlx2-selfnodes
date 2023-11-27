module "eks_self_managed_node_group" {
  source = "github.com/aws-samples/amazon-eks-self-managed-node-group"
  
  #"../modules/eks"
  
  #"github.com/careem111/amazon-eks-self-managed-node-group-modules//modules/eks?ref=v0.1"

  eks_cluster_name = var.eks_cluster_name
  instance_type    = "t3.medium"
  desired_capacity = 3
  min_size         = 2
  max_size         = 3
  subnets          = [module.eks_cluster_infra.pub_subnet_1_id, module.eks_cluster_infra.pub_subnet_2_id]
  key_name = var.ssh-key
  security_group_ids = [aws_security_group.node.id]

  node_labels = {
      "node.kubernetes.io/node-group" = "node-group-a"
  }

  # Outposts require that you encrypt all EBS volumes
  ebs_encrypted   = true
}

