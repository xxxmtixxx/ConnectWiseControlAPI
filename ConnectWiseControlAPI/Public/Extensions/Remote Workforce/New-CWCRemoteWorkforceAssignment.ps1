function ConvertTo-CustomJson {
    param(
        [Parameter(Mandatory=$True)]
        [array]$Array
    )

    $JsonArray = @()
    foreach ($Item in $Array) {
        if ($Item -is [array]) {
            $JsonArray += ('["' + ($Item -join '","') + '"]')
        } else {
            $JsonArray += ('"' + $Item + '"')
        }
    }
    return ('[' + ($JsonArray -join ',') + ']')
}

function New-CWCRemoteWorkforceAssignment {
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter(Mandatory=$True)]
        [guid]$SessionID,
        [string]$UserName,
        [string]$DisplayName
    )

    #Write-Host ""
    #Write-Host "SessionID: $SessionID"
    #Write-Host "UserName: $UserName"
    #Write-Host "DisplayName: $DisplayName"

    $Endpoint = 'App_Extensions/2c4f522f-b39a-413a-8807-dc52a2fce13e/Service.ashx/AddAssignmentNoteToSession'

    # Create the body as an array of arrays and strings
    $Body = ConvertTo-CustomJson @(
        @("All Machines"),
        @($SessionID.ToString()),
        "UserName:$UserName,UserDisplayName:$DisplayName"
    )

    #Write-Host ""
    #Write-Host "Body: $Body"

    $WebRequestArguments = @{
        Endpoint = $Endpoint
        Body = $Body
        Method = 'Post'
    }
    if ($PSCmdlet.ShouldProcess($WebRequestArguments.Body, "New-CWCRemoteWorkforceAssignment")) {
        Invoke-CWCWebRequest -Arguments $WebRequestArguments
    }
}
