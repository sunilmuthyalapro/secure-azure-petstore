Identity is a critical piece of ZTA in a cloud environment since there is no more perimeter in a cloud environment and an identity dictates what level of access it has to access resources and modify them.

There are few personas considered here

**User personas** 

**1. Developer**\
   a. Role : Contributor\
   b. Asset access : Develop environments, Azure Devops respos, Azure container registry, Azure Functions(specific), and Cosmos DB\
   c. Managed identity usage : Programmatic access to push container images to ACR or deploying resources through a managed identity or service principal with restricted permissions\
\
**2. Devops engineer**\
   a. Role : Contributor and ACR image signer\
   b. Asset access : CI/CD pipelines in Azure Devops, Kubernetes namespaces in AKS, Azure container registry and deployment configuration\
   c. Managed identity usage : Managaed identities with permissions to manage AKS deployments, update ACR, modify pipeline configuration and also to sign container images in ACR\
\
**3. Cloud administrator**\
   a. Role : Owner\
   b. Assets : Entire Azure subscriptions or specific resource groups\
   c. Managed identity usage : Managed identities are all setup and managed by administrators, so the level of access required by these identities to the right resources are dicteated by them. However, no managed identity will be assigned to the cloud admins themselves\
\
**4. Security personnel**\
   a. Role : Security Reader and Security Manager\
   b. Asset :  Azure Security Center, Azure Monitor, and Log Analytics workspaces.\
   c. Managed identity usage: Security personnel need to monitor security posture, analyze logs, and enforce security policies. A managed identity with read access to security data and configurations across services is required.\

**Managed identities**

For the project involving Azure Kubernetes Service (AKS), Azure Container Registry (ACR), Azure Functions, and Azure Cosmos DB, the following types of managed identities need to be created to ensure secure access management across different personas and services:

1. **AKS Cluster Managed Identity**:
   **Role name :** test-aks-cluster-manager
   This managed identity is used by the AKS cluster to interact securely with other Azure services like ACR for pulling container images and Azure Cosmos DB for data storage. It eliminates the need to store credentials in configuration files or code. 

3. **Azure Functions Managed Identity**:
   **Role name:** test-az-functions-manager
   When Azure Functions need to access other Azure resources, such as reading from or writing to Azure Cosmos DB, assigning a managed identity to these functions allows for secure and easy access management without embedding credentials in the application.

5. **CI/CD Pipelines Service Principal or Managed Identity**:
   **Role name:** test-pipeline-manager
   In Azure DevOps pipelines, a service principal or managed identity is used to deploy resources to Azure, manage configurations, and interact with other Azure services securely. This identity is crucial for automating deployment and resource management tasks in a secure manner.

Each of these managed identities plays a critical role in ensuring that each persona has the appropriate level of access to perform their tasks securely, without exposing sensitive credentials.

The identity controls seen here are applicable to both user principal and service principals running on a machine. Considering managed identities are for automation, they need to authenticate against services and this is achieved through key vaults.

![Identity](https://github.com/sunilmuthyalapro/secure-azure-petstore/assets/138375291/362d1248-39c8-471c-9717-e9b4f05246c7)
