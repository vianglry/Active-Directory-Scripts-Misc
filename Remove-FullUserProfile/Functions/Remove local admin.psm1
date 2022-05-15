
function New-ProfileListRegKeyBackup {
    $ProfileListBackupFolder = "C:\ProfileList.reg"
    $ProfileListRegKey = "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList"

    reg export $ProfileListRegKey $ProfileListBackupFolder
}


function Get-LocalUserRegistryKey {
    param (
        [ValidateNotNullOrEmpty()]
        [String]
        $UserAccounttobeRemoved
    )
    
    $ProfileListRegKey = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList\*"

    Get-Itemproperty $ProfileListRegKey -name ProfileImagePath | `
        Where-Object -property ProfileImagePath -Like ("*" + $UserAccounttobeRemoved)
} 



function Remove-FullUserAccountDetails {
    param (
        [string]
        $UserAccount
        
    )

    New-ProfileListRegKeyBackup 

    $UserAccounttobeRemoved = Get-LocalUserRegistryKey $UserAccount
    $LocalUserRegistryKeytobeRemoved = $UserAccounttobeRemoved.pspath 
    $LocalUserFiletobeRemoved = $UserAccounttobeRemoved.ProfileImagePath

    #Remove-LocalUser $LocalUserFiletobeRemoved
    Write-host "Remove user local user account " $UserAccount

    #Remove-Item $UserAccounttobeRemoved.PSPath
    Write-host "Remove local user file " $LocalUserFiletobeRemoved

    #Remove-Item $LocalUserRegistryKeytobeRemoved
    Write-host "Remove local user registry key " $LocalUserRegistryKeytobeRemoved
}

