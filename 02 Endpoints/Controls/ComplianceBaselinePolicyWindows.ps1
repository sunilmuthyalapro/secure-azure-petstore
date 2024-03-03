# Ensure the Microsoft.Graph PowerShell module is installed and imported
# Install-Module Microsoft.Graph -Scope CurrentUser
Import-Module Microsoft.Graph

# Authenticate to Microsoft Graph if not already done
# Connect-MgGraph -Scopes "DeviceManagementConfiguration.ReadWrite.All"

# Define the compliance policy JSON payload
$compliancePolicyJson = @"
{
  "displayName": "High Security Windows 10 Compliance Policy",
  "platformType": "windows10",
  "settings": {
    "passwordRequired": true,
    "passwordMinimumLength": 8,
    "passwordRequiredType": "alphanumeric",
    "osMinimumVersion": "10.0.19041",
    "osMaximumVersion": "10.0.19044",
    "earlyLaunchAntiMalwareDriverEnabled": true,
    "bitLockerEnabled": true,
    "secureBootEnabled": true,
    "codeIntegrityEnabled": true,
    "storageRequireEncryption": true,
    "firewallEnabled": true,
    "antivirusRequired": true,
    "antiSpywareRequired": true,
    "defenderEnabled": true,
    "defenderSignatureUpToDate": true
  },
  "scheduledActionsForRule": [
    {
      "ruleName": "PasswordRequired",
      "scheduledActionConfigurations": [
        {
          "actionType": "block",
          "gracePeriodHours": 0,
          "notificationTemplateId": "YourNotificationTemplateIdHere"
        }
      ]
    },
    {
      "ruleName": "DeviceCompliance",
      "scheduledActionConfigurations": [
        {
          "actionType": "sendEmailToUser",
          "gracePeriodHours": 0,
          "notificationTemplateId": "YourNotificationTemplateIdHere"
        },
        {
          "actionType": "markAsNonCompliant",
          "gracePeriodHours": 72,
          "notificationTemplateId": "YourNotificationTemplateIdHere"
        },
        {
          "actionType": "remotelyLock",
          "gracePeriodHours": 168,
          "notificationTemplateId": "YourNotificationTemplateIdHere"
        }
      ]
    }
  ]
}
"@

# Convert the JSON string to a PowerShell object
$compliancePolicyObject = $compliancePolicyJson | ConvertFrom-Json

# Create the compliance policy
New-MgDeviceManagementDeviceCompliancePolicy -BodyParameter $compliancePolicyObject
