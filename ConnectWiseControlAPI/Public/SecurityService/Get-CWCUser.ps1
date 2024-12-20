function Get-CWCUser {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$True)]
        [string]$User
    )

    try {
        Write-Host "Retrieving security configuration info..."
        $Security = Get-CWCSecurityConfigurationInfo -ErrorAction Stop
        
        # Filter for the 'Internal' user source
        $Internal = $Security.UserSources | Where-Object { $_.ResourceKey -eq $script:InternalUserSource }
        
        if (-not $Internal) {
            Write-Error "Unable to find the internal user source."
            return $null
        }

        Write-Host "Searching for user in internal source..."
        
        # Search for the user by either username or email
        $UserMatch = $Internal.Users | Where-Object { $_.Name -eq $User -or $_.Email -eq $User }
        
        if ($UserMatch) {
            Write-Host "Successfully retrieved user: $User"
            return $UserMatch
        } else {
            Write-Error "User not found: $User"
            return $null
        }
    } catch {
        Write-Error "Error retrieving user: $_"
        return $null
    }
}