# project-eks
```
devops-project/
│
├── terraform/                     # Infra Pipeline Code
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── backend.tf
│   │
│   ├── envs/
│   │   └── staging.tfvars
│   │
│   └── modules/
│       └── eks/
│           ├── main.tf
│           ├── variables.tf
│           └── outputs.tf
│
├── app/                           # Application Code (Java)
│   ├── src/
│   │   └── main/java/com/example/App.java
│   │
│   ├── target/                    # Generated after build (ignored in git)
│   │   └── *.jar
│   │
│   ├── pom.xml
│   ├── Dockerfile
│   │
│   └── k8s/                       # Kubernetes manifests
│       ├── deployment.yaml
│       └── service.yaml
│
├── jenkins/
│   ├── Jenkinsfile-infra          # Infra pipeline
│   └── Jenkinsfile-app            # App pipeline
│
└── README.md

```

```
Terraform Pipeline
   ↓
Creates EKS
   ↓
Stores cluster_name in SSM (/eks/cluster_name)
   ↓
-----------------------------
App Pipeline Starts
   ↓
Reads cluster_name from SSM
   ↓
aws eks update-kubeconfig
   ↓
kubectl deploy

```
```
Terraform Pipeline
   ↓
Creates EKS Cluster (example: dev-eks-cluster)
   ↓
Stores in SSM:
/eks/cluster_name = dev-eks-cluster
   ↓
----------------------------
Jenkins Pipeline
   ↓
Reads from SSM
   ↓
CLUSTER_NAME = dev-eks-cluster
   ↓
Uses it here:
aws eks update-kubeconfig --name dev-eks-cluster

```
