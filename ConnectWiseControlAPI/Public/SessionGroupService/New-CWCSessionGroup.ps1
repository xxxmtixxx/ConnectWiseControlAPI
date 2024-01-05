function New-CWCSessionGroup {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string]$ComputerName,
        [Parameter(Mandatory)]
        [string]$UserDisplayName
    )

    # Retrieve the existing Group Sessions and ensure it's an array even if it's a single object
    $existingSessionGroups = @(Get-CWCSessionGroup)

    # Output the existing session groups as JSON before appending the new session group
    $existingSessionGroupsJson = $existingSessionGroups | ConvertTo-Json -Depth 10
    # Write-Host "Existing Session Groups JSON before appending new session group:"
    # Write-Host $existingSessionGroupsJson

    # Create a new object for the Group Session with the same property names as the existing ones
    $newSessionGroup = New-Object PSObject -Property @{
        Name = $UserDisplayName
        SessionFilter = "Name LIKE '$ComputerName'"
        SessionType = 2
        SubgroupExpressions = ""
    }

    # Append the new session group object to the existing session groups array
    $existingSessionGroups += $newSessionGroup

    # Convert the list of Group Sessions to JSON
    $body = $existingSessionGroups | ConvertTo-Json -Depth 10

    $Endpoint = 'Services/SessionGroupService.ashx/SaveSessionGroups'

    $WebRequestArguments = @{
        Endpoint = $Endpoint
        Body = $body
        Method = 'Post'
    }

    # Send the web request
    # $result = Invoke-CWCWebRequest -Arguments $WebRequestArguments
    # Invoke-CWCWebRequest -Arguments $WebRequestArguments

    # Return a hashtable with separate keys for the existing session groups and the new session group
    return @{
        ExistingSessionGroups = $existingSessionGroups
        NewSessionGroup = $newSessionGroup
        WebRequestArguments = $WebRequestArguments
        Body = $body
    }
}