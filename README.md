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
* No Google Cloud SDK or Terraform install locally

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
