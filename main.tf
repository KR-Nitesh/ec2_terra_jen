#Provider_Plugin_Definition

terraform{
    required_providers {
      aws={
          source="hashicorp/aws"
      }
    }
}

#Provider_Configuration

provider "aws" {
  region="ap-south-1"
  
}

#Resource Declaration

resource "aws_vpc" "varanasitax"{
    cidr_block = "172.10.0.0/16"
    tags={
        Name="varanasitax"
    }
}

resource "aws_subnet" "varanasiprivsbn"{
    vpc_id = aws_vpc.varanasitax.id
    cidr_block = "172.10.5.0/24"
    tags={
        Name="varanasiprivsbn"
    }
}

resource "aws_security_group" "varanasisg" {
  vpc_id = aws_vpc.varanasitax.id
  ingress{
      from_port=22
      to_port=22
      cidr_blocks=["0.0.0.0/0"]
      protocol="tcp"
  }
  egress{
      from_port = 0
      to_port = 0
      cidr_blocks = ["0.0.0.0/0"]
      protocol = "-1"
  }
  tags={
      Name="varanasisshssg"
  }
}

resource "aws_key_pair" "bsbkey" {
  key_name="bsbkey"
  public_key="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDMci2B/OmMGJm7B7xmaInXfqfDLbnS/nnCIh72mExEy5kabtBgDvuqfca6mWpFVpF3BMpYVWRNUMCkdx3U3dZd/W1IAyaRc9iIc2TLAiE58lfrNgvJ2Vh++PLwd2sHrW7ZLLeZNBFWshy1PjpgyqFHyZEIX0SU2W2K9stGxv8sse4zCfWOdXLCI498z3U7vRO6DNc4byzgsnbg+HgRT/vt85Ta1HhEodrSKWKIYfqH48ApdHF8sgzmiJqG5QM/uQB7qz7sQf4/dDjJt4nFesVGNNRt2M2wtq7q7lQSD3hr4xjaxU/iEC2NGninLvM1idueo5wD1aJBflzprsQPtLLoyOvbUVXfOu6Bunbqovrj1wqkhxrFhW51s2OlOU53gGrKvssPZR202pn7w2gs2QIOXzz2v+6z2w547oBgoPh+eC2GcF7ngN3EM3ZXPkMAgOgFtQlWfCjLROi5KWdAhKX/8EWJJeI8o54ywFlA85mZj2qi779QoAZMAy7IoZt7018= nitesh@JNode1"

}

resource "aws_instance" "varanasi_ec2" {
  subnet_id=aws_subnet.varanasiprivsbn.id
  instance_type="t2.micro"
  ami="ami-006d3995d3a6b963b"
  vpc_security_group_ids = [ aws_security_group.varanasisg.id ]
  key_name = aws_key_pair.bsbkey.key_name
  associate_public_ip_address = true
  tags={
      Name="varanasi_ec2"
  }
}