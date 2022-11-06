function Add-CompanyUserToADGroup {
    param (
        [string]$Employee,
        [string]$ADGroup
    )

    $adcreds = Get-Credential
    Add-ADGroupMember $EmployeeUsername -Identity $ADGroup -Credential $adcreds -Confirm:$false
    $Employee = Get-ADUser $EmployeeUsername -Properties memberof
    $Employee.memberof
}