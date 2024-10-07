function Add-CWCUserRequiredRole {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [string]$RoleName
    )

    $Endpoint = 'Services/SecurityService.ashx/SaveRole'

    $SessionGroups = @('My Assigned Machines')

    $Body = ConvertTo-Json -Depth 10 @(
        "",
        $RoleName,
        @(),
        @(
            @{
                "AccessControlType" = 0
                "Name" = "ViewSessionGroup"
                "SessionGroupFilter" = 7
                "SessionGroupPath" = $SessionGroups
                "OwnershipFilter" = 0
            },
            @{
                "AccessControlType" = 0
                "Name" = "JoinSession"
                "SessionGroupFilter" = 7
                "SessionGroupPath" = $SessionGroups
                "OwnershipFilter" = 0
            },
            @{
                "AccessControlType" = 0
                "Name" = "TransferFilesInSession"
                "SessionGroupFilter" = 7
                "SessionGroupPath" = $SessionGroups
                "OwnershipFilter" = 0
            }
            @{
                "AccessControlType" = 0
                "Name" = "PrintInSession"
                "SessionGroupFilter" = 7
                "SessionGroupPath" = $SessionGroups
                "OwnershipFilter" = 0
            }
            @{
                "AccessControlType" = 0
                "Name" = "HostSessionWithoutConsent"
                "SessionGroupFilter" = 7
                "SessionGroupPath" = $SessionGroups
                "OwnershipFilter" = 0
            }
        )
    )
    Write-Verbose $Body

    $WebRequestArguments = @{
        Endpoint = $Endpoint
        Body = $Body
        Method = 'Post'
    }
    Invoke-CWCWebRequest -Arguments $WebRequestArguments
}