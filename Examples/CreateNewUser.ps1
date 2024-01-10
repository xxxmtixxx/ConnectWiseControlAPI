# Prompt for new user information
$newUserDisplayName = Read-Host -Prompt 'Enter the new user display name'
$newUserNameEmail = Read-Host -Prompt 'Enter the users email address'
$newUserPassword = Read-Host -Prompt 'Enter the users password'
$computerName = Read-Host -Prompt 'Enter the computer name'

# Define server variables
$username = '' # Admin User
$password = '' # Admin password
$otpSecret = '' # Admin OTP secret key (16 characters)
$server = 'changeme.screenconnect.com' # Modify URL

# Define new user role
$newUserRole = 'Remote Workforce'

# Define new user secure password string
$securePassword = ConvertTo-SecureString $newUserPassword -AsPlainText -Force

# Create a PSCredential object for API credentials
$credentials1 = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $username, (ConvertTo-SecureString -String $password -AsPlainText -Force)

# Create PSCredential object for new user
$credentials2 = New-Object System.Management.Automation.PSCredential ($newUserNameEmail, $securePassword)

# Explicitly set SSL/TLS
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# Install API Module
$documentsPath=[Environment]::GetFolderPath('MyDocuments');$url='https://github.com/xxxmtixxx/ConnectWiseControlAPI/archive/refs/heads/master.zip';$moduleName='ConnectWiseControlAPI';$modulePath=Join-Path $documentsPath 'WindowsPowerShell\Modules';$tempPath=Join-Path $env:TEMP ($moduleName+'.zip');Invoke-WebRequest -Uri $url -OutFile $tempPath;$tempDir='.'+$moduleName+'_temp';$extractPath=Join-Path $HOME $tempDir;Expand-Archive -Path $tempPath -DestinationPath $extractPath -Force;$sourceFolder=Join-Path $extractPath ('ConnectWiseControlAPI-master/'+$moduleName);$destinationFolder=Join-Path $modulePath $moduleName;if (!(Test-Path $destinationFolder)) {New-Item -Path $destinationFolder -ItemType Directory | Out-Null};Copy-Item -Path "$sourceFolder\*" -Destination $destinationFolder -Recurse -Force

# Import the ConnectWise Control API module
Import-Module $moduleName -Force

# Connect to the ConnectWise Control API
$ConnectSplat = @{
    Server = $server
    Credentials = $credentials1
    secret = ConvertTo-SecureString -String $otpSecret -AsPlainText -Force
}
Connect-CWC @ConnectSplat

# Create New User
$NewUser = @{
    Credentials = $credentials2
    Email = $newUserNameEmail
    DisplayName = $newUserDisplayName
    OTP = 'email'
    SecurityGroups = $newUserRole
}
New-CWCUser @NewUser

# Retrieve the list of machines/sessions
$sessions = Get-CWCSession -Type 'Access'

# Display all machines and their SessionIDs
foreach ($session in $sessions) {
    #Write-Host "Machine Name: $($session.Name), Machine SessionID: $($session.SessionID)"
}

# Find the SessionID for the given computer name
$machineSessionID = ($sessions | Where-Object { $_.Name -eq $computerName }).SessionID

# Check if the SessionID was found
if (-not $machineSessionID) {
    Write-Host "Machine with name $computerName not found."
    # If the machine is not found, you might want to stop the script or handle the error appropriately
    exit
}

# If the SessionID is found, proceed with the assignment
$assignmentParams = @{
    SessionID = $machineSessionID # The SessionID of the machine to assign
    UserName = $newUserNameEmail # The username of the user to assign to the machine
    DisplayName = $newUserDisplayName # The display name of the user to assign to the machine
}

# Create the new remote workforce assignment
New-CWCRemoteWorkforceAssignment @assignmentParams
