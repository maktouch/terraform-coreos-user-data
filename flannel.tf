variable "enable_flannel" {
  default = "true"
}

variable "flannel_public-ip" {
  default = ""
}

variable "flannel_etcd-endpoints" {
  default = ""
}

variable "flannel_etcd-prefix" {
  default = ""
}

variable "flannel_etcd-keyfile" {
  default = ""
}

variable "flannel_etcd-certfile" {
  default = ""
}

variable "flannel_interface" {
  default = ""
}

variable "flannel_subnet-file" {
  default = ""
}

variable "flannel_ip-masq" {
  default = ""
}

resource "template_file" "flannel_unit" {
  template = "${file("${path.module}/templates/enabled-unit.yml")}"

  vars {
    service = "flannel"
    enabled = "${var.enable_flannel}"
  }
}

resource "template_file" "flannel" {
  template = "${file("${path.module}/templates/flannel.yml")}"

  vars {
    public-ip       = "${var.flannel_public-ip}"
    etcd-endpoints  = "${var.flannel_etcd-endpoints}"
    etcd-prefix     = "${var.flannel_etcd-prefix}"
    etcd-keyfile    = "${coalesce(var.flannel_etcd-keyfile, var.etcd2_key-file)}"
    etcd-certfile   = "${coalesce(var.flannel_etcd-certfile, var.etcd2_cert-file)}"
    interface           = "${var.flannel_interface}"
    subnet-file     = "${var.flannel_subnet-file}"
    ip-masq         = "${var.flannel_ip-masq}"
  }
}