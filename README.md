## IaC/Automated Deployment Tech Test
The challenge:

>### DevOps Engineer - Tech Test
>#### Instructions
>We believe in `infrastructure as code` and automation of deployments.  We would like you to demonstrate your understanding and use of modern automated infrastructure and sysadmin. To demonstate this, your goal is to provision a simple web application of your choice that has a backend and database store (write a simple app or use an off-the-shelf set of Docker images).  Create an orchestrated cluster of nodes using any provisioning tool of your choice and deploy the application using an orchestration layer (e.g. Docker Swarm, Kubernetes, etc) to scale the application.  
>#### Solution notes
>* In the solution please provide clear instructions that allow us to replicate the solution from scratch.  
>* As an infrastructure provider, please use GCP or Azure.
>* Commit often to show work in progress rather than one big push.  Trial-and-error is allowed and encouraged.
>* The web application does not have to delivery any particular functionality.  What we are testing is the ability to compose an application and database layer in a correct fashion, even if they do not talk to each other in any interesting way. 
>####  Submitting
>* Put your solution in a public Github repo and send a link. Include a clear README with installation instructions.

### Outline Plan:
* Use GCP as the infrastructure provider
* Use Terraform to provision nodes
* Use Kubernetes for container orchestration
* Use a couple of sample Docker images as the app/DB

### My Assumptions:
* Google Cloud account set up and ready to go
* No Google Cloud SDK or Terraform pre-installed locally

### Install & Initialise Google Cloud SDK

Enable `apt-transport-https` if not already done:
```bash
sudo apt-get install apt-transport-https ca-certificates gnupg
```

Add the Google repo as a package source:
```bash
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
```

Add Google Cloud's public key:
```bash
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
```

Update local package lists and install the Google Cloud SDK package:
```bash
sudo apt-get update && sudo apt-get install google-cloud-sdk
```

Initialise the Google Cloud SDK:
```bash
gcloud init
```
* Login when prompted
* Select a project created previously, or create a new one

### Install Terraform
Visit the [Terraform download page](https://www.terraform.io/downloads.html) to determine the appropriate package for your OS, copy the link target and use it with `wget` to retrieve the package:
```bash
wget -O terraform.zip https://releases.hashicorp.com/terraform/0.12.20/terraform_0.12.20_linux_amd64.zip
```
Unzip:
```bash
sudo unzip -d /opt/terraform terraform.zip
```
Update .profile to add path entry and source it:
```bash
echo "PATH=${PATH}:/opt/terraform" >> ~/.profile && . ~/.profile
```
Verify install:
```bash
# terraform --version
Terraform v0.12.20
```

### Create GCP Service Account for Terraform
* Log in to GCP Console, from menu select "APIs & Services" followed by "Credentials"
* Click "+ CREATE CREDENTIALS" and select "Service account" from the menu
* Enter a service account name, click "CREATE"
* Select "Project" from the role menu, choose "Editor" from the sub-menu, click "CONTINUE"
* On the next screen, click "+ CREATE KEY"
  * Select "JSON" as the key type 
  * Click "CREATE" and save the key file

### Enable Kubernetes Engine API
* In GCP Console, select "APIs & Services" followed by "Dashboard"
* Click "+ ENABLE APIS AND SERVICES"
* In the search box, enter "Kubernetes"
* Select "Kubernetes Engine API"
* Click "ENABLE"

### Deploy
Call `terraform apply` in the directory into which this repo has been cloned.  You will be prompted for:
* A username to set for the k8s cluster
* A password to set for the k8s cluster
* The path to the credentials JSON file previously downloaded when creating the service account

The Terraform configuration in this repo will create a 3-node k8s cluster running the DockerCon EU '17 Wordsmith demo app, containing the following resources:
* A single replica DB deployment and service
* A triple replica API deployment and service
* A triple replica web/frontend deployment and service with LoadBalancer

Access the app on port 8081 of the LoadBalancer IP.

### Cleanup
Call `terraform destroy` to clean up.
