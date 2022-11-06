function Remove-CompanyUserFromADGroup {
    Param (
        [string]$EmployeeUsername,
        [string]$ADGroup
    )

    $adcreds = Get-Credential
    Remove-ADGroupMember -members $EmployeeUsername -Identity $ADGroup -Credential $adcreds -Confirm:$false
    $Employee = Get-ADUser $EmployeeUsername -Properties memberof
    $Employee.memberof
}