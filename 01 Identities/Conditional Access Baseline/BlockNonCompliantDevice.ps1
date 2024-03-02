# Install the Microsoft Graph PowerShell module if not already installed
Install-Module -Name Microsoft.Graph.Authentication, Microsoft.Graph.Identity.Signins -Scope CurrentUser -Force -AllowClobber

# Import the modules
Import-Module Microsoft.Graph.Authentication
Import-Module Microsoft.Graph.Identity.Signins

# Define your Azure AD credentials and other necessary details
$tenantId = 'your-tenant-id'
$appId = 'your-client-id'
$secret = 'your-client-secret'

# Authenticate
Connect-MgGraph -ClientID $appId -TenantId $tenantId -ClientSecret $secret

# Define policy settings
$policyName = "Block Non-Compliant Devices"
$requireCompliantDevice = $true

# Define conditions
$conditions = @{
    "includeDeviceConditions" = $true
    "devicePlatformConditions" = @(
        @{
            "platform" = "android"
            "complianceLevel" = "compliant"
        },
        @{
            "platform" = "ios"
            "complianceLevel" = "compliant"
        },
        @{
            "platform" = "windows"
            "complianceLevel" = "compliant"
        }
    )
}

# Create the Conditional Access policy
New-MgConditionalAccessPolicy -DisplayName $policyName -State "Enabled" -Conditions $conditions
