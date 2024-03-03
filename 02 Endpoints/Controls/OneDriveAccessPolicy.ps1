#This script follows the best practices highlighted in Microsoft's OneDrive policy to sync settings : https://learn.microsoft.com/en-us/sharepoint/use-group-policy#allow-syncing-onedrive-accounts-for-only-specific-organizations

# Install the Microsoft.Graph module if not already installed
Install-Module -Name Microsoft.Graph

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

# Define policy configurations

# Allow syncing OneDrive accounts for only specific organizations
$allowTenantListPolicy = @{
    displayName = "Allow syncing OneDrive accounts for only specific organizations"
    description = "Policy to allow syncing OneDrive accounts only for specific organizations"
    properties = @{
        allowedOrganizations = @("organization1.com", "organization2.com")
    }
}

# Limit the sync app upload rate to a percentage of throughput
$automaticUploadBandwidthPercentagePolicy = @{
    displayName = "Limit the sync app upload rate to a percentage of throughput"
    description = "Policy to limit the sync app upload rate"
    properties = @{
        uploadBandwidthPercentage = 50
    }
}

# Prevent users from syncing lists shared from other organizations
$blockExternalListSyncPolicy = @{
    displayName = "Prevent users from syncing lists shared from other organizations"
    description = "Policy to prevent users from syncing lists shared from other organizations"
    properties = @{
        blockExternalListSync = $true
    }
}

# Prevent users from syncing libraries and folders shared from other organizations
$blockExternalSyncPolicy = @{
    displayName = "Prevent users from syncing libraries and folders shared from other organizations"
    description = "Policy to prevent users from syncing libraries and folders shared from other organizations"
    properties = @{
        blockExternalSync = $true
    }
}

# Block syncing OneDrive accounts for specific organizations
$blockTenantListPolicy = @{
    displayName = "Block syncing OneDrive accounts for specific organizations"
    description = "Policy to block syncing OneDrive accounts for specific organizations"
    properties = @{
        blockedOrganizations = @("organization3.com", "organization4.com")
    }
}

# Set the default location for the OneDrive folder
$defaultRootDirPolicy = @{
    displayName = "Set the default location for the OneDrive folder"
    description = "Policy to set the default location for the OneDrive folder"
    properties = @{
        defaultRootDir = "C:\Users\username\OneDrive"
    }
}

# Convert synced team site files to online-only files
$dehydrateSyncedTeamSitesPolicy = @{
    displayName = "Convert synced team site files to online-only files"
    description = "Policy to convert synced team site files to online-only files"
    properties = @{
        dehydrateSyncedTeamSites = $true
    }
}

# Prevent authentication from automatically happening
$disableAutoConfigPolicy = @{
    displayName = "Prevent authentication from automatically happening"
    description = "Policy to prevent authentication from automatically happening"
    properties = @{
        disableAutoConfig = $true
    }
}

# Prevent users from changing the location of their OneDrive folder
$disableCustomRootPolicy = @{
    displayName = "Prevent users from changing the location of their OneDrive folder"
    description = "Policy to prevent users from changing the location of their OneDrive folder"
    properties = @{
        disableCustomRoot = $true
    }
}

# Hide the "Deleted files are removed everywhere" reminder
$disableFirstDeleteDialogPolicy = @{
    displayName = "Hide the 'Deleted files are removed everywhere' reminder"
    description = "Policy to hide the 'Deleted files are removed everywhere' reminder"
    properties = @{
        disableFirstDeleteDialog = $true
    }
}

# Hide the messages to sync Consumer OneDrive files
$disableNewAccountDetectionPolicy = @{
    displayName = "Hide the messages to sync Consumer OneDrive files"
    description = "Policy to hide the messages to sync Consumer OneDrive files"
    properties = @{
        disableNewAccountDetection = $true
    }
}

# Prevent users from getting silently signed in to offline experiences on the web
$disableNucleusSilentConfigPolicy = @{
    displayName = "Prevent users from getting silently signed in to offline experiences on the web"
    description = "Policy to prevent users from getting silently signed in to offline experiences on the web"
    properties = @{
        disableNucleusSilentConfig = $true
    }
}

# Prevent Lists sync from running on the device
$disableNucleusSyncPolicy = @{
    displayName = "Prevent Lists sync from running on the device"
    description = "Policy to prevent Lists sync from running on the device"
    properties = @{
        disableNucleusSync = $true
    }
}

# Prevent users at your organization from enabling offline mode in OneDrive on the web
$disableOfflineModePolicy = @{
    displayName = "Prevent users at your organization from enabling offline mode in OneDrive on the web"
    description = "Policy to prevent users from enabling offline mode in OneDrive on the web"
    properties = @{
        disableOfflineMode = $true
    }
}

# Prevent users at your organization from enabling offline mode in OneDrive on the web for libraries and folders that are shared from other organizations
$disableOfflineModeForExternalLibrariesPolicy = @{
    displayName = "Prevent users at your organization from enabling offline mode in OneDrive on the web for libraries and folders that are shared from other organizations"
    description = "Policy to prevent users from enabling offline mode in OneDrive on the web for libraries and folders shared from other organizations"
    properties = @{
        disableOfflineModeForExternalLibraries = $true
    }
}

# Continue syncing when devices have battery saver mode turned on
$disablePauseOnBatterySaverPolicy = @{
    displayName = "Continue syncing when devices have battery saver mode turned on"
    description = "Policy to continue syncing when devices have battery saver mode turned on"
    properties = @{
        disablePauseOnBatterySaver = $true
    }
}

# Continue syncing on metered networks
$disablePauseOnMeteredNetworkPolicy = @{
    displayName = "Continue syncing on metered networks"
    description = "Policy to continue syncing on metered networks"
    properties = @{
        disablePauseOnMeteredNetwork = $true
    }
}

# Prevent users from syncing personal OneDrive accounts
$disablePersonalSyncPolicy = @{
    displayName = "Prevent users from syncing personal OneDrive accounts"
    description = "Policy to prevent users from syncing personal OneDrive accounts"
    properties = @{
        disablePersonalSync = $true
    }
}

# Disable the tutorial that appears at the end of OneDrive Setup
$disableTutorialPolicy = @{
    displayName = "Disable the tutorial that appears at the end of OneDrive Setup"
    description = "Policy to disable the tutorial that appears at the end of OneDrive Setup"
    properties = @{
        disableTutorial = $true
    }
}

# Set the maximum size of a user's OneDrive that can download automatically
$diskSpaceCheckThresholdMBPolicy = @{
    displayName = "Set the maximum size of a user's OneDrive that can download automatically"
    description = "Policy to set the maximum size of a user's OneDrive that can download automatically"
    properties = @{
        diskSpaceCheckThresholdMB = 20480 # Example: 20 GB
    }
}

# Limit the sync app download speed to a fixed rate
$downloadBandwidthLimitPolicy = @{
    displayName = "Limit the sync app download speed to a fixed rate"
    description = "Policy to limit the sync app download speed to a fixed rate"
    properties = @{
        downloadBandwidthLimit = "512 KB/s"
    }
}

# Coauthor and share in Office desktop apps
$enableAllOcsiClientsPolicy = @{
    displayName = "Coauthor and share in Office desktop apps"
    description = "Policy to enable coauthoring and sharing in Office desktop apps"
    properties = @{
        enableAllOcsiClients = $true
    }
}

# Enable automatic upload bandwidth management for OneDrive
$enableAutomaticUploadBandwidthManagementPolicy = @{
    displayName = "Enable automatic upload bandwidth management for OneDrive"
    description = "Policy to enable automatic upload bandwidth management for OneDrive"
    properties = @{
        enableAutomaticUploadBandwidthManagement = $true
    }
}

# Allow users to choose how to handle Office file sync conflicts
$enableHoldTheFilePolicy = @{
    displayName = "Allow users to choose how to handle Office file sync conflicts"
    description = "Policy to allow users to choose how to handle Office file sync conflicts"
    properties = @{
        enableHoldTheFile = $true
    }
}

# Exclude specific kinds of files from being uploaded
$enableODIgnoreListFromGPOPolicy = @{
    displayName = "Exclude specific kinds of files from being uploaded"
    description = "Policy to exclude specific kinds of files from being uploaded"
    properties = @{
        enableODIgnoreListFromGPO = $true
    }
}

# Enable sync health reporting for OneDrive
$enableSyncAdminReportsPolicy = @{
    displayName = "Enable sync health reporting for OneDrive"
    description = "Policy to enable sync health reporting for OneDrive"
    properties = @{
        enableSyncAdminReports = $true
    }
}

# Use OneDrive Files On-Demand
$filesOnDemandEnabledPolicy = @{
    displayName = "Use OneDrive Files On-Demand"
    description = "Policy to enable OneDrive Files On-Demand"
    properties = @{
        filesOnDemandEnabled = $true
    }
}

# Require users to confirm large delete operations
$forcedLocalMassDeleteDetectionPolicy = @{
    displayName = "Require users to confirm large delete operations"
    description = "Policy to require users to confirm large delete operations"
    properties = @{
        forcedLocalMassDeleteDetection = $true
    }
}

# Set the sync app update ring
$gpoSetUpdateRingPolicy = @{
    displayName = "Set the sync app update ring"
    description = "Policy to set the sync app update ring"
    properties = @{
        gpoSetUpdateRing = "Enterprise"
    }
}

# Prevent users from moving their Windows known folders to OneDrive
$kfmBlockOptInPolicy = @{
    displayName = "Prevent users from moving their Windows known folders to OneDrive"
    description = "Policy to prevent users from moving their Windows known folders to OneDrive"
    properties = @{
        kfmBlockOptIn = $true
    }
}

# Prevent users from redirecting their Windows known folders to their PC
$kfmBlockOptOutPolicy = @{
    displayName = "Prevent users from redirecting their Windows known folders to their PC"
    description = "Policy to prevent users from redirecting their Windows known folders to their PC"
    properties = @{
        kfmBlockOptOut = $true
    }
}

# Prompt users to move Windows known folders to OneDrive
$kfmOptInWithWizardPolicy = @{
    displayName = "Prompt users to move Windows known folders to OneDrive"
    description = "Policy to prompt users to move Windows known folders to OneDrive"
    properties = @{
        kfmOptInWithWizard = $true
    }
}

# Silently move Windows known folders to OneDrive
$kfmSilentOptInPolicy = @{
    displayName = "Silently move Windows known folders to OneDrive"
    description = "Policy to silently move Windows known folders to OneDrive"
    properties = @{
        kfmSilentOptIn = $true
    }
}

# Prompt users when they delete multiple OneDrive files on their local computer
$localMassDeleteFileDeleteThresholdPolicy = @{
    displayName = "Prompt users when they delete multiple OneDrive files on their local computer"
    description = "Policy to prompt users when they delete multiple OneDrive files on their local computer"
    properties = @{
        localMassDeleteFileDeleteThreshold = 50 # Example: 50 files
    }
}

# Block file downloads when users are low on disk space
$minDiskSpaceLimitInMBPolicy = @{
    displayName = "Block file downloads when users are low on disk space"
    description = "Policy to block file downloads when users are low on disk space"
    properties = @{
        minDiskSpaceLimitInMB = 1024 # Example: 1 GB
    }
}

# Allow OneDrive to disable Windows permission inheritance in folders synced read-only
$permitDisablePermissionInheritancePolicy = @{
    displayName = "Allow OneDrive to disable Windows permission inheritance in folders synced read-only"
    description = "Policy to allow OneDrive to disable Windows permission inheritance in folders synced read-only"
    properties = @{
        permitDisablePermissionInheritance = $true
    }
}

# Prevent the sync app from generating network traffic until users sign in
$preventNetworkTrafficPreUserSignInPolicy = @{
    displayName = "Prevent the sync app from generating network traffic until users sign in"
    description = "Policy to prevent the sync app from generating network traffic until users sign in"
    properties = @{
        preventNetworkTrafficPreUserSignIn = $true
    }
}

# Specify SharePoint Server URL and organization name
$sharePointOnPremFrontDoorUrlPolicy = @{
    displayName = "Specify SharePoint Server URL and organization name"
    description = "Policy to specify SharePoint Server URL and organization name"
    properties = @{
        sharePointOnPremFrontDoorUrl = "https://sharepoint.organization.com"
    }
}

# Specify the OneDrive location in a hybrid environment
$sharePointOnPremPrioritizationPolicy = @{
    displayName = "Specify the OneDrive location in a hybrid environment"
    description = "Policy to specify the OneDrive location in a hybrid environment"
    properties = @{
        sharePointOnPremPrioritization = "Onedrive"
    }
}

# Silently sign in users to the OneDrive sync app with their Windows credentials
$silentAccountConfigPolicy = @{
    displayName = "Silently sign in users to the OneDrive sync app with their Windows credentials"
    description = "Policy to silently sign in users to the OneDrive sync app with their Windows credentials"
    properties = @{
        silentAccountConfig = $true
    }
}

# Configure team site libraries to sync automatically
$tenantAutoMountPolicy = @{
    displayName = "Configure team site libraries to sync automatically"
    description = "Policy to configure team site libraries to sync automatically"
    properties = @{
        tenantAutoMount = $true
    }
}

# Limit the sync app upload speed to a fixed rate
$uploadBandwidthLimitPolicy = @{
    displayName = "Limit the sync app upload speed to a fixed rate"
    description = "Policy to limit the sync app upload speed to a fixed rate"
    properties = @{
        uploadBandwidthLimit = "1 MB/s"
    }
}

# Warn users who are low on disk space
$warningMinDiskSpaceLimitInMBPolicy = @{
    displayName = "Warn users who are low on disk space"
    description = "Policy to warn users who are low on disk space"
    properties = @{
        warningMinDiskSpaceLimitInMB = 1024 # Example: 1 GB
    }
}

# Create policies

$allowTenantListPolicyId = (New-MgDeviceManagementConditionalAccessPolicy -Policy $allowTenantListPolicy).Id
$automaticUploadBandwidthPercentagePolicyId = (New-MgDeviceManagementConditionalAccessPolicy -Policy $automaticUploadBandwidthPercentagePolicy).Id
$blockExternalListSyncPolicyId = (New-MgDeviceManagementConditionalAccessPolicy -Policy $blockExternalListSyncPolicy).Id
$blockExternalSyncPolicyId = (New-MgDeviceManagementConditionalAccessPolicy -Policy $blockExternalSyncPolicy).Id
$blockTenantListPolicyId = (New-MgDeviceManagementConditionalAccessPolicy -Policy $blockTenantListPolicy).Id
$defaultRootDirPolicyId = (New-MgDeviceManagementConditionalAccessPolicy -Policy $defaultRootDirPolicy).Id
$dehydrateSyncedTeamSitesPolicyId = (New-MgDeviceManagementConditionalAccessPolicy -Policy $dehydrateSyncedTeamSitesPolicy).Id
$disableAutoConfigPolicyId = (New-MgDeviceManagementConditionalAccessPolicy -Policy $disableAutoConfigPolicy).Id
$disableCustomRootPolicyId = (New-MgDeviceManagementConditionalAccessPolicy -Policy $disableCustomRootPolicy).Id
$disableFirstDeleteDialogPolicyId = (New-MgDeviceManagementConditionalAccessPolicy -Policy $disableFirstDeleteDialogPolicy).Id
$disableNewAccountDetectionPolicyId = (New-MgDeviceManagementConditionalAccessPolicy -Policy $disableNewAccountDetectionPolicy).Id
$disableNucleusSilentConfigPolicyId = (New-MgDeviceManagementConditionalAccessPolicy -Policy $disableNucleusSilentConfigPolicy).Id
$disableNucleusSyncPolicyId = (New-MgDeviceManagementConditionalAccessPolicy -Policy $disableNucleusSyncPolicy).Id
$disableOfflineModePolicyId = (New-MgDeviceManagementConditionalAccessPolicy -Policy $disableOfflineModePolicy).Id
$disableOfflineModeForExternalLibrariesPolicyId = (New-MgDeviceManagementConditionalAccessPolicy -Policy $disableOfflineModeForExternalLibrariesPolicy).Id
$disablePauseOnBatterySaverPolicyId = (New-MgDeviceManagementConditionalAccessPolicy -Policy $disablePauseOnBatterySaverPolicy).Id
$disablePauseOnMeteredNetworkPolicyId = (New-MgDeviceManagementConditionalAccessPolicy -Policy $disablePauseOnMeteredNetworkPolicy).Id
$disablePersonalSyncPolicyId = (New-MgDeviceManagementConditionalAccessPolicy -Policy $disablePersonalSyncPolicy).Id
$disableTutorialPolicyId = (New-MgDeviceManagementConditionalAccessPolicy -Policy $disableTutorialPolicy).Id
$diskSpaceCheckThresholdMBPolicyId = (New-MgDeviceManagementConditionalAccessPolicy -Policy $diskSpaceCheckThresholdMBPolicy).Id
$downloadBandwidthLimitPolicyId = (New-MgDeviceManagementConditionalAccessPolicy -Policy $downloadBandwidthLimitPolicy).Id
$enableAllOcsiClientsPolicyId = (New-MgDeviceManagementConditionalAccessPolicy -Policy $enableAllOcsiClientsPolicy).Id
$enableAutomaticUploadBandwidthManagementPolicyId = (New-MgDeviceManagementConditionalAccessPolicy -Policy $enableAutomaticUploadBandwidthManagementPolicy).Id
$enableHoldTheFilePolicyId = (New-MgDeviceManagementConditionalAccessPolicy -Policy $enableHoldTheFilePolicy).Id
$enableODIgnoreListFromGPOPolicyId = (New-MgDeviceManagementConditionalAccessPolicy -Policy $enableODIgnoreListFromGPOPolicy).Id
$enableSyncAdminReportsPolicyId = (New-MgDeviceManagementConditionalAccessPolicy -Policy $enableSyncAdminReportsPolicy).Id
$filesOnDemandEnabledPolicyId = (New-MgDeviceManagementConditionalAccessPolicy -Policy $filesOnDemandEnabledPolicy).Id
$forcedLocalMassDeleteDetectionPolicyId = (New-MgDeviceManagementConditionalAccessPolicy -Policy $forcedLocalMassDeleteDetectionPolicy).Id
$gpoSetUpdateRingPolicyId = (New-MgDeviceManagementConditionalAccessPolicy -Policy $gpoSetUpdateRingPolicy).Id
$kfmBlockOptInPolicyId = (New-MgDeviceManagementConditionalAccessPolicy -Policy $kfmBlockOptInPolicy).Id
$kfmBlockOptOutPolicyId = (New-MgDeviceManagementConditionalAccessPolicy -Policy $kfmBlockOptOutPolicy).Id
$kfmOptInWithWizardPolicyId = (New-MgDeviceManagementConditionalAccessPolicy -Policy $kfmOptInWithWizardPolicy).Id
$kfmSilentOptInPolicyId = (New-MgDeviceManagementConditionalAccessPolicy -Policy $kfmSilentOptInPolicy).Id 
