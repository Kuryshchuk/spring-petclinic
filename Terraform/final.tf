provider "aws" {
  shared_credentials_file = "credentials"
  profile = "default"
  region = "eu-central-1"
}


resource "aws_instance" "jenkins_master" {
  ami             = "ami-05f7491af5eef733a"
  instance_type   = "t2.micro"
  key_name        = "JenkinsKey"
  user_data       = "file(jenkins.sh)"
  subnet_id       = "subnet-ea076580"
  vpc_security_group_ids = [aws_security_group.sg1.id]
  lifecycle {ignore_changes  = ["user_data"]}
  tags = {Name ="jenkins_master"}
}


resource "aws_instance" "ansible_master" {
  ami             = "ami-05f7491af5eef733a"
  instance_type   = "t2.micro"
  key_name        = "JenkinsKey"
  user_data       = "file(ansible.sh)"
  subnet_id       = "subnet-ea076580"
  vpc_security_group_ids = [aws_security_group.sg1.id]
  lifecycle {ignore_changes  = ["user_data"]}
  tags = {Name ="ansible_master"}
}


resource "aws_instance" "kuber_master" {
  ami             = "ami-05f7491af5eef733a"
  instance_type   = "t3a.small"
  key_name        = "JenkinsKey"
  user_data       = "file(kuber_master.sh)"
  subnet_id       = "subnet-ea076580"
  vpc_security_group_ids = [aws_security_group.sg1.id]
  lifecycle {ignore_changes  = ["user_data"]}
    tags = {Name= "kuber_master"}
}


resource "aws_instance" "kuber_node" {
  ami             = "ami-05f7491af5eef733a"
  instance_type   = "t3a.small"
  key_name        = "JenkinsKey"
  user_data       = "file(kuber_node.sh)"
  subnet_id       = "subnet-ea076580"
  vpc_security_group_ids = [aws_security_group.sg1.id]
    tags = {Name= "kuber_node"}
  lifecycle {ignore_changes  = ["user_data"]}
}



resource "aws_security_group" "sg1" {
  name        = "sg_allow_ssh"
  description = "Allow ssh 22 port"



  ingress {
        from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 

  }


  ingress {
        from_port = 0
    to_port   = 6443
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 

  }

  ingress {
        from_port = 0
    to_port   = 10248
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 

  }

  ingress {
        from_port = 0
    to_port   = 10250
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 

  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }


  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

   ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }
}
