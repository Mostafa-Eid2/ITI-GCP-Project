variable "project_id" {
  type        = string
  default = "mostafaeid"
}

variable "region" {
  type        = string
  description = "europe-west1"
}

variable "zone" {
  type        = string
  description = "europe-west1-b"
}

variable "sa-key" {
  type        = string
  default = "~/GCP-ITI3/secrets/mostafaeid-be7bbfcd21dd.json"
}

variable "region2" {
  type    = string
  default = "us-east1"
}
variable "zone2" {
  type    = string
  default = "us-east1-b"
}

variable "rolezzz" {
  type = list(string)
  default = [
    "roles/source.reader",
    "roles/artifactregistry.writer",
    "roles/artifactregistry.reader",
    "roles/container.clusterAdmin"
  ]
}
