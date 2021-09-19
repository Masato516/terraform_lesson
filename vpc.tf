module "vpc_subnet_1" {
  source = "./modules/vpc_subnet"

  vpc_cidr_block               = "10.0.0.0/16"
  public_subnet_1c_cidr_block  = "10.0.0.0/24"
  private_subnet_1c_cidr_block = "10.0.1.0/24"
  private_subnet_1d_cidr_block = "10.0.2.0/24"
}