function New-UserDetailsMap {
    @{
    "EmployeeFirstName" = " ";
    "EmployeeLastName" = " ";
    "EmployeeFullName" = " ";
    "EmployeeUsername" = " ";
    "EmployeeEmail" = " ";
    "Title" = " ";
    "Manager" = " ";
    "Department" = " ";
    "Company" = " "
    }
}

function New-BranchMap {
    @{
        "BranchName" = " ";
        "BranchNickname" = " ";
        "StreetAddress" = " ";
        "City" = " ";
        "State" = " ";
        "PostalCode" = " ";
        "Country" = " ";
        "OfficePhone" = " ";
        "Fax" = " "
    }
}

function Get-TFIUsersDetails {
    param (
        [string]$NewEmployeeUsername
    )
    Get-ADUser $NewEmployeeUsername -Properties *
}

Function Set-ValuesForUserDetailsMap {
    param (
        [hashtable]$UserMap
    )

    $UserMap.Title = Read-host "Enter Employee Title "
    $UserMap.Manager = Read-host "Enter the USERNAME of the Employee's Supervisor "
    $UserMap.Department = Read-host "Enter Employee Department "
    $UserMap.Company = Read-host "Enter the company the Employee will work for "
}

Function Set-ValuesFoBranchMap {
    param (
        [hashtable]$BranchMap
    )
    $BranchMap.BranchName = Read-Host "Enter the full Branch Name (ex. Grand Rapids, Cherry Hill)"
    $BranchMap.BranchNickName = Read-Host "Enter the 3 Letter Branch Nickname (ex. GRP, CHE)"
    $BranchMap.StreetAddress = Read-Host "Street Address of the employee's branch. "
    $BranchMap.City  = Read-Host "Enter the City in which the employee's branch is located "
    $BranchMap.State  = Read-Host "Enter the State in which the employee's branch is located "
    $BranchMap.PostalCode  = Read-Host "Enter the Postal Code for the employee's branch "
    $BranchMap.Country  = Read-Host "Enter the County in which the employee's branch is located "
    $BranchMap.OfficePhone  = Read-Host "Enter the Branch's Office Phone Number. "
    $BranchMap.Fax = Read-Host "Enter the branch's Fax Number. "   
}

function Set-NEWTFIUserDetails {
    param(
        [String]$NewEmployeeUsername
    )
    Write-host "Enter your Active Directory Admin Credentials"
    Start-Sleep 1
    $ADCreds = Get-Credential
    $UserMap = New-UserDetailsMap
    $BranchMap = New-BranchMap00

    $NewEmployeeADAccount = Get-TFIUsersDetails $NewEmployeeUsername

    if ($null -ne $NewEmployeeADAccount) {
        $UserMap.EmployeeFirstName = $NewEmployeeADAccount.GivenName
        $UserMap.EmployeeLastName = $NewEmployeeADAccount.Surname
        $UserMap.Emailaddress = $NewEmployeeADAccount.EmailAddress
        $UserMap.EmployeeUsername = $NewEmployeeADAccount.samaccountname
    }else {
        Write-Host "User Not Found"
    }

    Set-ValuesForUserDetailsMap $UserMap
    Set-ValuesFoBranchMap $BranchMap

    Set-ADUser $UserMap.EmployeeUsername -Title $UserMap.Title -Credential $ADCreds
    Set-ADUser $UserMap.EmployeeUsername -Department $UserMap.Department -Credential $ADCreds
    Set-ADUser $UserMap.EmployeeUsername -Company $UserMap.Company -Credential $ADCreds
    Set-ADUser $UserMap.EmployeeUsername -Office $UserMap.Department -Credential $ADCreds 
    Set-ADUser $UserMap.EmployeeUsername -Manager $UserMap.Manager -Credential $ADCreds

    Set-ADUser $UserMap.EmployeeUsername -StreetAddress $BranchMap.StreetAddress -Credential $ADCreds
    Set-ADUser $UserMap.EmployeeUsername -city $BranchMap.City -Credential $ADCreds
    Set-ADUser $UserMap.EmployeeUsername -State $BranchMap.State -Credential $ADCreds
    Set-ADUser $UserMap.EmployeeUsername -PostalCode $BranchMap.PostalCode -Credential $ADCreds
    Set-ADUser $UserMap.EmployeeUsername -Country $BranchMap.Country -Credential $ADCreds
    Set-ADUser $UserMap.EmployeeUsername -OfficePhone $BranchMap.OfficePhone -Credential $ADCreds
    Set-ADUser $UserMap.EmployeeUsername  -Fax $BranchMap.Fax -Credential $ADCreds
}