
provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region = "${var.region}"
}

provider "atlas" {
  token = "${var.atlas_token}"
}

resource "aws_instance" "example" {
 #ami = "${lookup(var.amis,var.region)}"
  ami = "${data.atlas_artifact.myamis.metadata_full.region-ap-south-1}"
  instance_type = "t2.micro"
}

output "pub_ip" {
  value = "${aws_instance.example.public_ip}"
}



data "atlas_artifact" "myamis" {
  name = "atlas_username/myamis"
  type = "amazon.image"
  version = "2"
}
