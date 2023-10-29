# GCP Project - Mostafa Eid ☁️

# Infrastructure as Code (IAC) Empowerment with Terraform on Google Cloud ☁️

## Project Overview

This project highlights the incredible capabilities of Infrastructure as Code (IAC) powered by Terraform, enabling the creation of robust infrastructure on Google Cloud Platform (GCP).

## Project Components  🛠️

### Terraform Infrastructure 🏗️
- **Custom Terraform Modules**: Develop and deploy custom Terraform modules to orchestrate and build essential infrastructure components on Google Cloud Platform. This includes setting up Identity and Access Management (IAM) policies, configuring network essentials (Virtual Private Cloud, subnets, firewall rules, and Network Address Translation), provisioning compute resources (private virtual machines and a Google Kubernetes Engine (GKE) standard cluster spanning three zones), and managing storage resources through the Artifact Registry.

### MongoDB Deployment 🌐
- **Highly Available MongoDB Replica Set**: Establish a MongoDB replica set that spans across three distinct zones, ensuring top-notch high availability and data redundancy for your database.

### Containerization with Docker 🐳
- **Dockerization of Node.js Application**: Containerize the Node.js web application, making it easy to connect seamlessly with the MongoDB replica set across different zones.

### Exposure via Ingress and Load Balancer 🌐
- **Web Application Exposure**: Showcase your web application to the world by employing an ingress controller and load balancer. This ensures seamless accessibility and efficient distribution of incoming traffic.

This project is poised to make a significant impact by demonstrating the transformative potential of Infrastructure as Code using Terraform, all while harnessing the capabilities of Google Cloud Platform. ☁️

![Requirements](./project Requirements/Requirements.png)

## 🚀 Getting Started

### Prerequisites  🛠️

Before you begin, ensure you have the following installed:

- Terraform 🏗️
- Google Cloud SDK ☁️
- Docker  🐋
- Kubectl ☸

### Install The Google Cloud SDK ☁️.

1. Open a terminal window.
2. Run the following command:
   
  ```
  sudo apt-get install google-cloud-sdk-gke-gcloud-auth-plugin
  ```
3. Configure your GCP account and select your project by running:

  ```
  gcloud auth login
  ```
4. You will be prompted to enter the project ID.
> [!NOTE]
> you can get the project id by going to the GCP console and in the dashboard you will find the project id
> The chosen project will be the default project for all the gcloud commands till changed

--------

### Clone this repository to your local environment to start setting up the infrastructure.

To set up the infrastructure, clone this repository to your local environment:
  ```
  git clone https://github.com/Mostafa-Eid2/ITI-GCP-Project.git
  cd GCP-ITI
  ```

--------

### Setting Up Terraform for GCP 🏗️

To integrate GCP with Terraform, follow these steps:

1. Create a Service Account for Terraform. You can do this through the GCP console or by using gcloud commands:

   - Using the GCP Console:
     1.1. Navigate to IAM in the GCP console.
     1.2. Find the "Service Accounts" section.
     1.3. Create a new service account.
     1.4. Assign the "Editor" role to this service account.
     1.5. Within the service account, locate the "Keys" section.
     1.6. Add a new key and select the JSON format.
     1.7. After adding the key, it will be automatically downloaded.
     1.8. Copy this key to your project directory.
     1.9. Create a directory named "secrets."
     1.10. Paste your key into this "secrets" directory.

   - Using gcloud Commands:
     1. Create the service account and grant it the "Editor" role:
     ```bash
     gcloud iam service-accounts create SERVICE_ACCOUNT_NAME --display-name "DISPLAY_NAME"
     gcloud projects add-iam-policy-binding YOUR_PROJECT_ID --member=serviceAccount:SERVICE_ACCOUNT_EMAIL --role=roles/editor
     ```

     2. Generate a key for the service account:
     ```bash
     gcloud iam service-accounts keys create KEY_FILE.json --iam-account SERVICE_ACCOUNT_EMAIL
     ```

     3. Copy this key to your project directory.
     4. Create a directory called "secrets."
     5. Place your key into this "secrets" directory.

2. Add the path to the service account key to your Terraform variables, enabling Terraform to use it in your configurations.

3. Execute your Terraform configuration files using the following commands:

   ```bash
   cd Terraform/
   terraform init
   terraform plan
   terraform apply

[!NOTE]
Please be aware that the terraform apply command may take up to 15 minutes to complete.

--------

### Startup Script 🖥️

1. The Startup script can be found in ```Scripts/Startupscript.sh``` and
2. The script automates the deployment process of a Node.js web application to Google Cloud Platform (GCP) using Docker and Kubernetes.
3. The script simplifies various tasks, including setting up the development environment, building Docker images, and deploying them to GCP's Artifact Registry.
4. The script Installs Dependencies: The script installs essential libraries, Git, Google Cloud SDK for GKE, Kubectl, and Docker.
5. The script Clones a Node.js web app
6. The script creates a Dockerfile for the Node.js app, builds a Docker image, and exposes it on port 5000.
7. The script installs & Confgures Tinyproxy which allows us to acces the Private VM instance from the local machine.
8. GCP Authentication: The script fetches a service account key, decrypts it, activates the service account, and configures Docker for GCP.
9. Cluster Connection: It connects to the GCP Kubernetes cluster.
10. The script pulls a MongoDB image, tags it, and pushes it to GCP Artifact Registry. It does the same for the Node.js app.

--------

### Post Terraform Apply

1. After applying the Terraform configuration, you'll want to access the private VM instance through Identity-Aware Proxy (IAP). Use the following command:
   ```
   gcloud compute ssh private-vm-instance --project=hendawy-iti-gcp --zone=us-east1-b --tunnel-through-iap
   ```
2. Once you've accessed the machine, check the progress of the startup script by viewing the log file:
   ```
   cat /var/log/syslog
   ```
3. If the script ran successfully, you can exit the machine by running the ```exit``` command.
   
> [!NOTE]
> You can also check if the script ran successfully by going to the Artifact Registry in the GCP console.
> You should find a repository called my-images, which contains two Docker images: node-app and mongoDB.
> You can see what it looks like in the Screenshots directory.

--------

### 🌐  Remotely access the GKE Cluster from the local machine

To remotely access the GKE cluster from your local machine, follow these steps:
1. Deploy a proxy daemon using Tinyproxy on your host to forward traffic to the cluster control plane.
2. Set up the remote client with cluster credentials and specify the proxy.
3. Obtain the cluster credentials using the following command:
   ```
   gcloud container clusters get-credentials gcp-k8s --zone europe-west1-b --project hendawy-iti-gcp --internal-ip
   ```
4. Connect to the cluster from the remote local private instance using IAP and deploy the web application:
   ```
   gcloud compute ssh private-vm-instance \
    --tunnel-through-iap \
    --project=hendawy-iti-gcp \
    --zone=us-east1-b \
    --ssh-flag="-4 -L8888:localhost:8888 -N -q -f" 2>/dev/null
   ```
5. Specify the proxy
   ```
   export HTTPS_PROXY=localhost:8888
   ```
6. Then Show GKE Nodes
   ```
   kubectl get nodes
   ```
> [!NOTE]
> There is a shell script called local_script.sh in the Scripts directory that automates these steps
> and applies the Kubernetes files for MongoDB (Backend Configuration) and the Node.js App (Frontend Configuration).
> You may need to change the absolute path of your project inside the local_script.sh file on line 22.
> You can run this script by executing the following commands:
> ```
> cd ../Scripts/
> source local_script.sh 
> ```
7. After running The Script You should run the following Command to get the The IP Address where the Web application is deployed:
   ```
   kubectl get svc -n node
   ```
8. Copy the External-IP and paste it into your browser to access the web application. This app displays the number of visits, which increases every time you reload the page.
9. this app has ```visists:number of visits``` every time you reload the ```number of visits``` will increase
10. since in Kubernetes (K8s), "stateful" means  that each pod in a stateful application has persistent storage to maintain its state. If the database fails for any reason, you can still access the data.
11. You can check this by destroying mongodb-0 and then reloading the browser. The ```number of visits``` will remain unchanged and increase from the last visit.
   ```
   curl <EXTERNAL_IP>
   delete pods mongodb-0-n mongo
   curl <EXTERNAL_IP>
   ```

--------

### 🧹 Clean Up

To clean up and delete all resources:
```
# Delete all pods by deleting namespaces
kubectl delete ns mongo node

# Stop listening on the remote client
netstat -lnpt | grep 8888 | awk '{print $7}' | grep -o '[0-9]\+' | sort -u | xargs sudo kill

# Change directory to Terraform
cd ../terraform

# Destroy all resources
terraform destroy
```

During the destruction, you'll need to delete the disks used by the databases from the Google Cloud Console. Go to Compute Engine, select Disks, and press Delete for all disks. 