resource "aws_vpc" "my_vpc" {
    cidr_block = "10.0.0.0/16"

    tags = {
      Name = "Roboshop"
      Environment = "DEV"
      Terraform = "True"
    }
  
}

resource "aws_subnet" "public_subnet" {
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = "10.0.1.0/24"

    tags = {
      Name = "Roboshop Public Subnet"
    }
  
}

resource "aws_subnet" "private_subnet" {
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = "10.0.2.0/24"

    tags = {
      Name = "Roboshop Private Subnet"
    }
}

resource "aws_internet_gateway" "my_net_gateway" {
    vpc_id = aws_vpc.my_vpc.id

    tags = {
      Name = "Roboshop Internet Gateway"
    }
}

resource "aws_route_table" "public_route_table" {
    vpc_id = aws_vpc.my_vpc.id
  
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.my_net_gateway.id
    }
    tags = {
      Name = "Roboshop Public route table"
    }
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "Roboshop private route table"
  }
}

resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "private_assoc" {
    subnet_id = aws_subnet.private_subnet.id
    route_table_id = aws_route_table.private_route_table.id
  
}