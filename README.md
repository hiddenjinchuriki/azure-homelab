Azure Home Lab - Terraform Infrastructure
# automated deployment of an Azure home lab using Terraform

Overview
This project automates the deployment of a fully functional Azure home lab using Terraform. The infrastructure mimics a typical SMB environment with Windows 11 and Windows Server 2019 VMs, networking, storage, security policies, monitoring, and automation. 

Features
Resource Group: centralized resource management
Netowrking: virtual networks, subnets, network security groups, etc
Compute: Windows 11 & Windows Server 2019 VMs
Security: NSGs, Public and Private IP configuration
Storage: Azure Storage Account with Blob Storage
Monitoring: Log Analytics Workspace for log collection
Automation: IaC with Terraform

File Structure
azure-homelab/
- .github/workflows/terraform.yml   # GitHub Actions for CI/CD
- main.tf                           # Main Terraform configuration
- variables.tf                      # Variables for Terraform
- outputs.tf                        # Terraform output values
- .gitignore                        # Ignore Terraform state files
- READ.md                           # Project documentation

Automation & CI/CD
This project includes a GitHub Actions pipeline to automate Terraform deployments
- On every push to main, Terraform runs plan and apply
- Ensures infrastructure consistency
- Can be extended for Terraform Cloud or Azure DevOps

Future Improvements
- Add Azure Active Directory Integration
- Implement Azure Firewall for better security
- Configure Azure VPN Gateway for hybrid networking
- Deploy Containerized Applications using AKS
- Use Terraform Remote State Storage (Azure Blob) for collaboration



