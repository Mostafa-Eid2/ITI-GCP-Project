variable "project_id" {
  type    = string
  default = "mostafaeid"
}

variable "region" {
  type    = string
  default = "europe-west1"
}

variable "zone" {
  type    = string
  default = "europe-west1-b"
}

variable "sa-key" {
  type    = string
  default = "~/GCP-ITI3/secrets/mostafaeid-be7bbfcd21dd.json"
}

variable "network_name" {
  type = string
}

variable "google_compute_subnet" {
}

variable "google_compute_subnet2" {
}

variable "sa_1_email" {
}

variable "K8S_email" {
}

variable "sa_1_key" {

}
variable "region2" {
  type    = string
  default = "us-east1"
}

variable "zone2" {
  type    = string
  default = "us-east1-b"
}

variable "startup_script" {
  default = "../Scripts/Startupscript.sh"
}

variable "vm_subnet2_cidr" {

}
