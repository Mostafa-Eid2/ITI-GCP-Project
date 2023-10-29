# Define the first service account
resource "google_service_account" "sa_1" {
  account_id   = "service"
  display_name = "GCP-iTi-Management-SA"
}

resource "google_project_iam_member" "sa_1_role" {
   count   = length(var.roles) 
   project = var.project_id 
   role    = var.roles[count.index]  
   member  = "serviceAccount:${google_service_account.sa_1.email}"
  
 }

# Define the second service account
resource "google_service_account" "K8S" {
  account_id   = "kubernetesnew" 
  display_name = "GCP-iTi-Sa2"
}

resource "google_project_iam_member" "artifact_reader_cluster" {
  project = var.project_id
  role    = "roles/artifactregistry.reader"
  member  = "serviceAccount:${google_service_account.K8S.email}"
}
