# A Zero Trust Architecture to the infamous Azure Petstore project

The Azure Pet Store project is a popular project (https://github.com/chtrembl/azure-cloud/tree/main/petstore) created by Chris Tremblay for people who are keen to learn Azure as a software developer. It's a great project to kick-off from scratch and see your results quickly. Considering this is a quick deployment exercise, a few shortcuts were taken by the original author for people see results. Let's don the hat of a cloud security architect and secure this fantastic project!

Let's take a look at the architecture below:

![image](https://github.com/sunilmuthyalapro/secure-azure-petstore/assets/138375291/6abd5395-0f21-429d-bb3e-09c4cadc5153)

At a quick glance you understand what are the Azure services and other applications being used and let's list them out.


Azure

1. Azure Active Directory
2. Azure Devops
3. App Service
4. Key Vault
5. API management gateway
6. Azure Kubernetes Services (AKS)
7. Cosmos Database
8. Service Bus
9. Logic Apps
10. Function App
11. Power App
12. Monitor
13. Application Insights
14. SignalR

Github

1. Github repository
2. Github Actions

The Microsoft Zero Trust Reference Architecture can be seen below:

![image](https://github.com/sunilmuthyalapro/secure-azure-petstore/assets/138375291/0e5f4664-d194-4eed-9a52-b0b9e06a142a)


This reference architecture is built using the below technology pillars

![image](https://github.com/sunilmuthyalapro/secure-azure-petstore/assets/138375291/7dc90b0e-69bf-4a4f-a420-8771638589bc)

There are some assumptions about this setup before creating/updating security controls:

1. The entire setup is available only on Azure and there is no hybrid setup
2. All users are working remotely
3. There is a custom CASB solution already in place before any of the Azure native controls can be considered


The controls are applied based on these technology pillars and the architecture diagrams will concentrate only on the assets and controls which each of these technology pillars will be applied. For example, in the identities folder, the architecture will show RBAC controls for the identities, but not show networking components. Let's get busy applying all these controls!
