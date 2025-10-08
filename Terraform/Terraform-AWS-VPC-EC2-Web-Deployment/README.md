🚀 Terraform AWS Basic Web Server Deployment
This project demonstrates how to provision a complete, secure, and internet-accessible web server environment on AWS using Terraform and the Infrastructure as Code (IaC) methodology.
The final output is an EC2 instance running an Apache web server, accessible from the public internet.
🌟 Key Features & Architecture
This Terraform stack automatically provisions all required networking and compute components for a basic AWS web infrastructure.
🏗️ 1. Networking Foundation (VPC & Subnets)
Component
Description
VPC (10.0.0.0/16)
Creates a logically isolated virtual network, serving as the secure container for all resources.
Public Subnet
Hosts the web server and automatically assigns public IPs for internet access.
Private Subnets (A & B)
Reserved for backend resources like databases or application servers (not directly accessible from the internet).

🌐 2. Internet Connectivity & Routing
Component
Description
Internet Gateway (IGW)
Enables communication between the VPC and the public internet.
Public Route Table
Routes all external traffic (0.0.0.0/0) from the public subnet through the IGW.

💻 3. Compute & Security
Component
Description
Security Group (my-SSH-Access)
Virtual firewall that allows SSH (Port 22) for secure login. Later, HTTP (Port 80) is added for web access.
EC2 Instance
A t2.micro Amazon Linux instance deployed in the public subnet to host the web application.

🧰 Technologies Used
Technology
Purpose
Terraform
Infrastructure as Code tool used to define, provision, and manage AWS resources.
AWS
Cloud provider hosting all resources (VPC, EC2, SG, etc.).
Bash / SSH
Used for remote administration and post-deployment setup.
Apache (httpd)
Web server software installed on EC2 to host and serve the HTML page.

⚙️ Deployment Instructions
✅ Prerequisites
Terraform CLI installed locally
AWS CLI installed and configured with valid credentials
Existing AWS Key Pair (named my-terra) imported into your AWS account
🚀 Steps to Launch
# 1️⃣ Clone this repository
git clone [YOUR-REPO-URL]
cd [PROJECT-DIRECTORY]

# 2️⃣ Initialize Terraform
terraform init

# 3️⃣ Review planned changes
terraform plan

# 4️⃣ Apply configuration
terraform apply
# Type 'yes' when prompted


🧩 Post-Deployment & Validation
🔐 Connect to the EC2 Instance
ssh -i "key.pem" ec2-user@[Public-IP]


🌍 Setup Apache Web Server
sudo yum update -y
sudo yum install httpd -y
sudo systemctl start httpd
sudo systemctl enable httpd

# Create test page
echo "<h1>✅ Success! Deployed by Terraform.</h1>" | sudo tee /var/www/html/index.html


🔓 Open HTTP Port (Port 80)
In AWS Console → Security Groups → my-SSH-Access → Add Inbound Rule:
Type: HTTP
Port: 80
Source: 0.0.0.0/0
🧠 Validate
Open your EC2 Public IP in a browser:
👉 http://<YOUR-PUBLIC-IP>
You should see:
✅ Success! Deployed by Terraform.
🧹 Cleanup
terraform destroy
# Type 'yes' when prompted
