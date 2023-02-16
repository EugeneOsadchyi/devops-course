# AWS Infrastructure

## Architecture diagram

```mermaid
---
title: AWS infrastructure architecture diagram
---
flowchart LR
  subgraph vpc["DevOps Course VPC (10.1.0.0/16)"]
    subgraph subnet_public["Public (10.1.1.0/24), eu-west-2a"]
      bastion["Bastion Host"]
    end

    subgraph subnet_private_1["Private (10.1.2.0/25, eu-west-2a)"]
      eks_node1["Node 1 (EKS NodeGroup)"] -.-> rds1[(Shared RDS)]
    end

    subgraph subnet_private_2["Private (10.1.2.128/25, eu-west-2b)"]
      eks_node2["Node 2 (EKS NodeGroup)"] -.-> rds2[(Shared RDS)]
    end

    rds1 <-. replication .->  rds2

    eks[EKS]
    eks <--> eks_node1
    eks <--> eks_node2
  end

  ssh(SSH) --> bastion
  bastion .-> |SSH| eks_node1
  bastion .-> |SSH| eks_node2

  style bastion stroke-width:2px,color:#fff,stroke-dasharray: 5 5

```

## Required environment variables
- `TF_VAR_database_username`
- `TF_VAR_database_password`


## Setup

1. Set the desired database username and password to the environment variables
   ```sh
   export TF_VAR_database_username=root
   export TF_VAR_database_password=password
   ```

2. Apply terraform
  ```sh
  terraform apply
  ```
3. After applying changes you will get hostname and port of the database in outputs

  ```sh
  Outputs:

  database_hostname = "devops-course-rds.csqt7fieauxh.eu-west-2.rds.amazonaws.com"
  database_port = 3306
  ```
4. Export them to the environment variables
  ```sh
   export DATABASE_HOSTNAME=devops-course-rds.csqt7fieauxh.eu-west-2.rds.amazonaws.com
   export DATABASE_PORT=3306
  ```
5. Continue with [Kubernetes Infrastructure](../k8s/README.md)
