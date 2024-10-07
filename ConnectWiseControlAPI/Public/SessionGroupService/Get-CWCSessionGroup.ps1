function Get-CWCSessionGroup {
  [CmdletBinding()]
  param ()

  $Endpoint = 'Services/SessionGroupService.ashx/session-groups'

  $WebRequestArguments = @{
    Endpoint = $Endpoint
    Method = 'Get'
  }

  $response = Invoke-CWCWebRequest -Arguments $WebRequestArguments

  # Assuming the response contains an array of session groups
  $sessionGroups = $response | ForEach-Object {
    # Create a custom object for each session group that includes the desired properties
    [PSCustomObject]@{
      Name = $_.Name
      SessionFilter = $_.SessionFilter
      SessionType = $_.SessionType
      SubgroupExpressions = $_.SubgroupExpressions
    }
  }

  return $sessionGroups
}
