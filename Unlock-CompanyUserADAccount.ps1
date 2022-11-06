function Unlock-TFIUserADAccount {
    Param (
        [string]$EmployeeUsername
    )

    $adcreds = Get-Credential
    Unlock-ADAccount $EmployeeUsername -Credential $adcreds -Confirm:$false
}



