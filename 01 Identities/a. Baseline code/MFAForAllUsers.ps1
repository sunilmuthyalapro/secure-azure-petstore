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
$policyName = "MFA for First Sign-in or After 30 Days"
$usersGroup = "sg-all-employees"
$signInFrequency = 30  # Days

# Define conditions
$conditions = @{
    "signInRiskLevels" = "All"
    "clientAppTypes" = "All"
    "users" = @{
        "includedGroups" = $usersGroup
    }
    "grantControls" = @{
        "operator" = "OR"
        "builtInControls" = "mfa"
    }
    "authenticationContexts" = @(
        @{
            "operator" = "AND"
            "firstSignIn" = $true
            "signInFrequency" = $true
            "frequencyInDays" = $signInFrequency
        }
    )
}

# Create the Conditional Access policy
New-MgConditionalAccessPolicy -DisplayName $policyName -State "Enabled" -Conditions $conditions
