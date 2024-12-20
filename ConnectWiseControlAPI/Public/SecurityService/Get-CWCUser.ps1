function Get-CWCUser {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$False)]
        [string]$User = '*'
    )

    try {
        Write-Host "Retrieving user: $User"

        # Set the API endpoint URL
        $Endpoint = 'Services/SecurityService.ashx/GetUser'

        # Create the body of the POST request
        $Body = ConvertTo-Json @(
            'InternalMembershipProvider', # Use InternalMembershipProvider as required
            $User
        )

        # Create the web request arguments
        $WebRequestArguments = @{
            Endpoint = $Endpoint
            Body = $Body
            Method = 'Post'
        }

        # Call the API
        Write-Host "Sending request to endpoint: $Endpoint for user $User"
        $Response = Invoke-CWCWebRequest -Arguments $WebRequestArguments

        if ($Response) {
            Write-Host "Successfully retrieved user data for: $User"
            
            # Return only the email addresses of the users
            $Emails = $Response | Select-Object -ExpandProperty Email
            return $Emails
        } else {
            Write-Warning "User not found: $User"
            return $null
        }
    } catch {
        Write-Error "Error retrieving user: $_"
        return $null
    }
}