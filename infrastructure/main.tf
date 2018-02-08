# Create a new instance of the latest Ubuntu 14.04 on an
# t2.micro node with an AWS Tag naming it "HelloWorld"
provider "aws" {
  region  = "sa-east-1"
  profile = "beld"
}

# Retrieve the default VPC such that we don't need to
# create additional ones just for this example
data "aws_vpc" "default" {
  default = true
}

# Retrieve the latest Ubuntu Artful (17.10) AMI that
# the Canonical team released in our region.
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-artful-17.10-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

# Create a security group that will allow us to both
# SSH into the instance as well as access prometheus
# publicly (note.: you'd not do this in prod - otherwise
# you'd have prometheus publicly exposed).
resource "aws_security_group" "main" {
  name   = "main"
  vpc_id = "${data.aws_vpc.default.id}"

  ingress {
    from_port   = 9090
    to_port     = 9090
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create an EC2 instance that will hold both prometheus
# itself as well as 
resource "aws_instance" "web" {
  ami                    = "${data.aws_ami.ubuntu.id}"
  instance_type          = "t2.micro"
  user_data              = "${file("./init-script.sh")}"
  key_name               = "aws-sa-key1"
  vpc_security_group_ids = ["${aws_security_group.main.id}"]

  tags {
    tips_ops_node_type   = "opstips-fleet-masters"
    tips_ops_environment = "dev1"
  }
}
