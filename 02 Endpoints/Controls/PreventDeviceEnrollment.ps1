# Install the Microsoft.Graph module if not already installed
# Install-Module -Name Microsoft.Graph

# Import required modules
Import-Module Microsoft.Graph

# Prompt the user to input their credentials securely
$tenantId = Read-Host "Please enter your Azure AD tenant ID"
$clientId = Read-Host "Please enter your Azure AD client ID"
$clientSecret = Read-Host "Please enter your Azure AD client secret" -AsSecureString

# Convert secure string to plain text
$clientSecretPlainText = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($clientSecret))

# Authenticate with Microsoft Graph using client credentials flow
Connect-MgGraph -Scopes "https://graph.microsoft.com/.default" -TenantId $tenantId -ClientId $clientId -ClientSecret $clientSecretPlainText

# Create enrollment restriction policy
$policy = New-MgDeviceEnrollmentConfiguration -DisplayName "Restrict Personal Device Enrollment" `
    -Description "This policy restricts personal devices from enrolling into the MDM solution." `
    -Priority 0 `
    -EnrollmentRestrictions @(
        @{
            ODataType = "#microsoft.graph.deviceEnrollmentLimitConfiguration"
            Limit = 1
            Type = "deviceLimit"
        },
        @{
            ODataType = "#microsoft.graph.deviceEnrollmentLimitConfiguration"
            Limit = 0
            Type = "limit"
            Platform = "windows"
        },
        @{
            ODataType = "#microsoft.graph.deviceEnrollmentLimitConfiguration"
            Limit = 0
            Type = "limit"
            Platform = "android"
        },
        @{
            ODataType = "#microsoft.graph.deviceEnrollmentLimitConfiguration"
            Limit = 0
            Type = "limit"
            Platform = "iOS"
        }
    )

# Assign the policy to a group (replace 'groupId' with your group ID)
$groupId = "groupId"
Add-MgDeviceEnrollmentConfigurationAssignment -DeviceEnrollmentConfigurationId $policy.Id -GroupId $groupId

Write-Host "Enrollment restriction policy created and assigned successfully."
