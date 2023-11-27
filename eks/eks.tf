
module "eks_cluster_infra" {
    source = "github.com/careem111/vlx2-tform-modules//modules/infra?ref=v0.0.1"

    https://github.com/careem111/vlx2-tform-modules.git
  
    vpc_cidr  = "10.1.0.0/16"
    vpc_name = "vlx2-eks"
    az1 = "us-east-1b"
    az2 = "us-east-1c"
    pub_subnet_1_cidr = "10.1.1.0/24"
    pub_subnet_2_cidr = "10.1.2.0/24"
    pub_subnet_1_name = "public-sub-1"
    pub_subnet_2_name = "public-sub-2"
    pub_rt_name = "vlx2-eks-public-routing-table"

}

# resource "aws_eks_cluster" "eks" {
#   name = var.eks_cluster_name
#   role_arn = aws_iam_role.master.arn
#   version = "1.26"

#   vpc_config {
#     subnet_ids = [module.eks_cluster_infra.pub_subnet_1_id, module.eks_cluster_infra.pub_subnet_2_id]
#     #pub_subnet_1_id is already exposed in the output.tf in modules, thats why we can call it here
#     security_group_ids = [aws_security_group.node.id]
#   }
  
#   depends_on = [
#     aws_iam_role_policy_attachment.AmazonEKSClusterPolicy,
#     aws_iam_role_policy_attachment.AmazonEKSServicePolicy,
#     aws_iam_role_policy_attachment.AmazonEKSVPCResourceController,
#     aws_iam_role_policy_attachment.AmazonEKSVPCResourceController,
#     module.eks_cluster_infra.pub_subnet_1_id,
#     module.eks_cluster_infra.pub_subnet_2_id,
#   ]

# }


module "eks_self_managed_node_group" {
  source = "github.com/aws-samples/amazon-eks-self-managed-node-group//?ref=v0.0.1"

  eks_cluster_name = var.eks_cluster_name
  version = "1.26"
  instance_type    = "t3.medium"
  desired_capacity = 3
  min_size         = 2
  max_size         = 3
  subnets          = [module.eks_cluster_infra.pub_subnet_1_id, module.eks_cluster_infra.pub_subnet_2_id]
  key_name = var.ssh_key
  security_group_ids = [aws_security_group.node.id]

  node_labels = {
    "node.kubernetes.io/outpost"    = "op-0d4579457ff2dc345" # (Optional) Outpost ID label
    "node.kubernetes.io/node-group" = "node-group-a"         # (Optional) node-group name label
  }

  # Outposts require that you encrypt all EBS volumes
  ebs_encrypted   = true
}

