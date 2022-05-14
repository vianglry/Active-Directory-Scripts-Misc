Function Validate {
Param(
[Parameter(Mandatory=$true)]
[ValidateNotNullOrEmpty()]
[ValidatePattern("[a-zA-Z@'-][^*]")]
[String[]]$Requesteduser
)
}



$Requesteduser = Read-Host "Which employee would you like to remove? "



#Checking the User's input for errors runing the command

Try {

    Validate $Requesteduser


    $Users = Get-ADUser -Identity $Requesteduser -Properties memberof 


    $UserGroups = $Users.memberof | % {Get-ADGroup -Identity $_}


    #Variables for error notes and Print screen
    $RemovedUserGroups = $UserGroups.name
    $RemovedUser = $users.Name


    #Last chance to check make sure the name is correct
    $Answer = Read-Host "Are you sure you want to remove $RemovedUser from $RemovedUserGroups [Yes][No]"
    if ($Answer -eq "Yes"){


        write-host "Enter your Active Directory Credentials:"

        Sleep 2

        $creds = Get-Credential




        Write-Host "Removing $RemovedUser from the following groups:"

        write-host $UserGroups.name -Separator `n -ForegroundColor DarkGreen

        sleep 5

        ForEach ($group in $UserGroups){

            Remove-ADGroupMember -Identity $group -Members $Users -Credential $creds -confirm:$false
            Write-Host "Removing " -NoNewline 
            Write-host $users.Name -NoNewline -ForegroundColor DarkCyan
            Write-Host " from " -NoNewline
            Write-Host $group.name `n -NoNewline -ForegroundColor DarkGreen

            sleep 2

        }
    
        Add-Content -Path "C:\Users\rdavis\Tools\Scripts\Offboarding Scripts\Offboarding Errors\Offboarding Script Errors.txt" -Value "[ $date ][End Report]`nRemoved $removeduser from the following groups:`n$removedusergroups" -PassThru


    }
    elseif ($Answer -eq "No"){

        Read-Host "Exiting Offboarding Script. Press 'Enter' to close"
        exit

    }
    else {

        Read-Host "Exiting Offboarding Script. Press 'Enter' to close"
        exit

    }

}
#Can't find the user
catch [Microsoft.ActiveDirectory.Management.ADIdentityNotFoundException],[Microsoft.ActiveDirectory.Management.Commands.GetADUser] {

    write-host The User cannot be found. Check the name to ensure you have spelled it correctly

    $date = Get-date

    Add-Content -Path "C:\Users\rdavis\Tools\Scripts\Offboarding Scripts\Offboarding Errors\Offboarding Script Errors.txt" -Value "[ $date ][ Error ]`n $_" -PassThru

    Exit

}
#Credentials are incorrect
catch [MissingMandatoryParameter,Microsoft.PowerShell.Commands.GetCredentialCommand] {

    "There's a problem with your Credentials"

    $date = Get-date

    Add-Content -Path "C:\Users\rdavis\Tools\Scripts\Offboarding Scripts\Offboarding Errors\Offboarding Script Errors.txt" -Value "[ $date ][ Error ]`n $_" -PassThru

    Exit

}
#Invalid User Input
catch [ ParameterArgumentValidationError],[Validate] {

    "There's an error in the user input"

    $date = Get-date

    Add-Content -Path "C:\Users\rdavis\Tools\Scripts\Offboarding Scripts\Offboarding Errors\Offboarding Script Errors.txt" -Value "[ $date ][ Error ]`n $_" -PassThru

    Exit
}
#Anything else that goes wrong
catch {

    "An error occured and the operation has stopped"

    $date = Get-date

    Add-Content -Path "C:\Users\rdavis\Tools\Scripts\Offboarding Scripts\Offboarding Errors\Offboarding Script Errors.txt" -Value "[ $date ][ Error ]`n $_" -PassThru

    Exit

}
