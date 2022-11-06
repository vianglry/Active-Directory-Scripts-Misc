function Reset-CompanyUserADAccountPassword {
    param (
        [string]$EmployeeUsername
    )
    
    $adcreds = Get-Credential
    $NewUserPassword = (Read-Host -Prompt "Provide New Password" -AsSecureString)

    Set-ADAccountPassword $EmployeeUsername -newpassword $NewUserPassword -reset -Credential $adcreds -confirm:$false
    Set-ADUser $EmployeeUsername -ChangePasswordAtLogon $true -Credential $adcreds
}
