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