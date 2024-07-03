resource "aws_instance" "dev" {
  ami           = "ami-06c68f701d8090592"
  instance_type = "t2.micro"
  key_name = "terra"
  availability_zone = "us-east-1a"
  #security_groups = "sg-07ac7265afe515c71"

  tags = {
    Name = "dev"
    Env = "dev-env"
  }
}
###############################################################################################
#  NETWORK RESOURCE
###############################################################################################

resource "aws_vpc" "DEV-VPC" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "dev-vpc"
  }
}

resource "aws_subnet" "private-subnet" {
  vpc_id     = aws_vpc.DEV-VPC.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "private-subnet"
  }
}

resource "aws_subnet" "public-subnet" {
  vpc_id     = aws_vpc.DEV-VPC.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "public-subnet"
  }
}

resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.DEV-VPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-rt"
  }
}

resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.DEV-VPC.id

  route {
    cidr_block = "0.0.0.0/0"
   # gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "private-rt"
  }
}

resource "aws_route_table_association" "pub-rt-ass" {
  subnet_id      = aws_subnet.public-subnet.id
  route_table_id = aws_route_table.public-rt.id
}

resource "aws_route_table_association" "priv-rt-ass" {
  subnet_id      = aws_subnet.private-subnet.id
  route_table_id = aws_route_table.private-rt.id
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.DEV-VPC.id

  tags = {
    Name = "igw"
  }
}

/*
resource "aws_nat_gateway" "nat" {
#   allocation_id = aws_eip.nat.id
   subnet_id = aws_subnet.priv-rt.id
    
}
*/

/*
resource "aws_eip" "nat" {
   vpc = true
   
}
*/


resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.DEV-VPC.id

# INBOUND RULE
  ingress {
    description = "allow http inbound traffic"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

ingress {
    description = "allow https inbound traffic"
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "allow ssh inbound traffic"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

# OUTBOUND RULE
egress {
    description = "allow all outbound traffic"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}






