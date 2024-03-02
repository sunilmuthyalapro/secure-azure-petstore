Identity is a critical piece of ZTA in a cloud environment since there is no more perimeter in a cloud environment and an identity dictates what level of access it has to access resources and modify them.

There are few personas considered here

**1. Developer**
   a. Role : Contributor
   b. Asset access : Develop environments, Azure Devops respos, Azure container registry, Azure Functions(specific), and Cosmos DB
   c. Managed identity usage : Programmatic access to push container images to ACR or deploying resources through a managed identity or service principal with restricted permissions

**2. Devops engineer**
   a. Role : Contributor and ACR image signer
   b. Asset access : CI/CD pipelines in Azure Devops, Kubernetes namespaces in AKS, Azure container registry and deployment configuration
   c. Managed identity usage : Managaed identities with permissions to manage AKS deployments, update ACR, modify pipeline configuration and also to sign container images in ACR

**3. Cloud administrator**
   a. Role : Owner
   b. Assets : Entire Azure subscriptions or specific resource groups
   c. Managed identity usage : Managed identities are all setup and managed by administrators, so the level of access required by these identities to the right resources are dicteated by them. However, no managed identity will be assigned to the cloud admins themselves

**4. Security personnel**
   a. Role : Security Reader and Security Manager
   b. Asset :  Azure Security Center, Azure Monitor, and Log Analytics workspaces.
   c. Managed identity usage: Security personnel need to monitor security posture, analyze logs, and enforce security policies. A managed identity with read access to security data and configurations across services is required.



The identity controls seen here are applicable to both user principal and service principals running on a machine. Considering managed identities are for automation, they need to authenticate against services and this is achieved through key vaults.

![Identity](https://github.com/sunilmuthyalapro/secure-azure-petstore/assets/138375291/362d1248-39c8-471c-9717-e9b4f05246c7)
