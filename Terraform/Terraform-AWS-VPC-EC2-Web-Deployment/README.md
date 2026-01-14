# 🚀 Terraform AWS Production-Grade Web Server Infrastructure

This project showcases a **production-ready Infrastructure as Code (IaC) implementation** using **Terraform** to deploy a secure, scalable, and internet-accessible web server environment on **Amazon Web Services (AWS)**.

The infrastructure provisions an **EC2 instance running Apache**, hosted inside a properly designed **VPC architecture**, following real-world DevOps and cloud best practices.

---

## 🏗️ Architecture Diagram

```text
                    🌍 Internet
                         │
                         ▼
                ┌─────────────────┐
                │ Internet Gateway │
                └─────────────────┘
                         │
                         ▼
                ┌─────────────────┐
                │ Public Route Tbl │
                └─────────────────┘
                         │
                         ▼
        ┌────────────────────────────────┐
        │               VPC              │
        │        10.0.0.0 / 16            │
        │                                │
        │   ┌────────────────────────┐   │
        │   │      Public Subnet     │   │
        │   │    10.0.1.0 / 24       │   │
        │   │                        │   │
        │   │  ┌─────────────────┐  │   │
        │   │  │   EC2 Instance  │  │   │
        │   │  │  Apache Server  │  │   │
        │   │  │   (HTTP :80)   │  │   │
        │   │  └─────────────────┘  │   │
        │   └────────────────────────┘   │
        │                                │
        │   ┌────────────────────────┐   │
        │   │    Private Subnet A    │   │
        │   │    10.0.2.0 / 24       │   │
        │   └────────────────────────┘   │
        │                                │
        │   ┌────────────────────────┐   │
        │   │    Private Subnet B    │   │
        │   │    10.0.3.0 / 24       │   │
        │   └────────────────────────┘   │
        │                                │
        └────────────────────────────────┘
```

---

## 🌟 Key Features

- Fully automated AWS infrastructure using Terraform
- Secure VPC design with public and private subnets
- Controlled internet access using Internet Gateway & Route Tables
- SSH and HTTP access managed through Security Groups
- Production-aligned structure suitable for scaling and CI/CD integration
- Easy teardown to prevent unnecessary AWS charges

---

## 🧩 Infrastructure Components

### 🌐 Networking Layer

| Resource | Description |
|--------|-------------|
| VPC | Isolated virtual network (10.0.0.0/16) |
| Public Subnet | Hosts internet-facing EC2 instance |
| Private Subnets (A & B) | Reserved for backend/internal services |
| Internet Gateway | Enables VPC internet access |
| Route Tables | Controls outbound traffic routing |

### 🔐 Security Layer

| Resource | Description |
|--------|-------------|
| Security Group | Allows SSH (22) and HTTP (80) |
| Key Pair | Secure SSH access using `Assign-terra.pem` |

### 💻 Compute Layer

| Resource | Description |
|--------|-------------|
| EC2 Instance | t2.micro Amazon Linux |
| Web Server | Apache (httpd) |

---

## 🧰 Technology Stack

- **Terraform** – Infrastructure as Code
- **AWS** – EC2, VPC, Subnets, Route Tables, Security Groups
- **Apache HTTP Server** – Web hosting
- **Bash & SSH** – Server configuration

---

## ⚙️ Deployment Guide

### Prerequisites

- Terraform CLI
- AWS CLI configured
- Existing AWS Key Pair: `Assign-terra`

### 🚀 Provision Infrastructure

```bash
git clone <REPOSITORY-URL>
cd <PROJECT-DIRECTORY>

terraform init
terraform plan
terraform apply
```

Confirm with `yes` when prompted.

---

## 🧩 Post-Deployment & Validation

### 🔐 SSH Access

```bash
ssh -i "Assign-terra.pem" ec2-user@<PUBLIC-IP>
```

### 🌍 Configure Apache

```bash
sudo yum update -y
sudo yum install httpd -y
sudo systemctl start httpd
sudo systemctl enable httpd

echo "<h1>✅ Production Web Server Deployed via Terraform</h1>" | sudo tee /var/www/html/index.html
```

### 🔓 Enable HTTP Access

AWS Console → Security Groups → Assignment1-SSH-Access  
Add inbound rule:
- Type: HTTP
- Port: 80
- Source: 0.0.0.0/0

### 🧠 Verify Deployment

Visit in browser:

```
http://<PUBLIC-IP>
```

---

## 🧹 Infrastructure Cleanup

```bash
terraform destroy
```

Safely removes all AWS resources.

---

## 🚀 Production Readiness Notes

- Ready for Auto Scaling Group integration
- Can be extended with Load Balancer (ALB)
- Supports CI/CD pipelines (Jenkins, GitHub Actions)
- Terraform state can be moved to S3 + DynamoDB locking
- Separate environments (dev / stage / prod) easily achievable

---

## 🏁 Conclusion

This project reflects **real-world cloud engineering and DevOps practices**, demonstrating how Terraform can be used to build secure, modular, and production-ready AWS infrastructure.

Perfect for:
- DevOps portfolios
- Cloud interviews
- Terraform hands-on projects
- Infrastructure automation demonstrations

---

## 🧑‍💻 Author

**Yogi Jagtap**  
DevOps | Cloud | Infrastructure Automation  
Feel free to fork, enhance, and scale this project 🚀
