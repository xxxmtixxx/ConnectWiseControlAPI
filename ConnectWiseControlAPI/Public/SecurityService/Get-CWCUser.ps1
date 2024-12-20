function Get-CWCUser {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$True)]
        [string]$User
    )

    try {
        Write-Host "Retrieving user: $User"

        # Retrieve security configuration info
        $Security = Get-CWCSecurityConfigurationInfo -ErrorAction Stop

        # Print the UserSources structure for debug purposes
        if ($Security.UserSources) {
            Write-Host "User Sources Available:" -ForegroundColor Green
            $Security.UserSources | Format-Table -AutoSize
        } else {
            Write-Error "No User Sources Found."
            return $null
        }

        # Filter for the internal user source (InternalMembershipProvider)
        $InternalUsers = $Security.UserSources | Where-Object { $_.ResourceKey -eq 'InternalMembershipProvider' }

        if (-not $InternalUsers) {
            Write-Error "Unable to find the InternalMembershipProvider user source."
            return $null
        }

        # Extract users from the internal source
        $Users = $InternalUsers.Users
        if ($Users) {
            Write-Host "Found $($Users.Count) users in the InternalMembershipProvider source."

            # Search for the user by either Name or Email
            $UserMatch = $Users | Where-Object { $_.Name -eq $User -or $_.Email -eq $User }

            if ($UserMatch) {
                Write-Host "Successfully retrieved user: $User"
                return $UserMatch
            } else {
                Write-Error "User not found: $User"
                return $null
            }
        } else {
            Write-Host "No users found in the InternalMembershipProvider source."
            return $null
        }
    } catch {
        Write-Error "Error retrieving user: $_"
        return $null
    }
}