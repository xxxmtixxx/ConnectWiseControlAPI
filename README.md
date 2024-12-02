<h1 align="center">
  <br>
  <img src=".\Media\control-horiz-master.webp" alt="logo" width = 75% ></a>
  <br>
  ConnectWise Control API
  <br>
</h1>


<p align="center">
    • <a href="ConnectWiseControlAPI_Functions.md">List of Functions</a> •
</p>

<h4 align="center">

This is a PowerShell wrapper for ConnectWise Control

</h4>

<!-- Summary -->

ConnectWise Control New User Provisioning Script
This PowerShell script is tailored for administrators who need to efficiently create new users and assign them to machines within the ConnectWise Control platform. The script simplifies the user provisioning process by prompting for essential user details, configuring server variables, and defining user roles. It ensures security by converting the user's password to a secure string and handles the installation and importation of the necessary API module for ConnectWise Control.

Once set up, the script connects to the ConnectWise Control API, creates the new user with the specified details, and fetches the current list of machines/sessions. It then locates the specific machine by its SessionID and assigns the new user accordingly. If the specified machine is not found, the script halts execution to prevent any incorrect user assignments, maintaining the integrity of the system's configuration.

This script is a part of the ConnectWise Control API project and is designed to make the user provisioning workflow as seamless and error-free as possible.

[New User Provisioning Script](https://github.com/Rarity-Solutions/ConnectWiseControlAPI/blob/master/Examples/CreateNewUser.ps1)

<!-- Summary -->

## Manual API Download/Install

 The module can be installed by unzipping the master zip into one of your powershell modules folder, or by running the following one-liner:

```powershell
$documentsPath=[Environment]::GetFolderPath('MyDocuments');$url='https://github.com/Rarity-Solutions/ConnectWiseControlAPI/archive/refs/heads/main.zip';$moduleName='ConnectWiseControlAPI';$modulePath=Join-Path $documentsPath 'WindowsPowerShell\Modules';$tempPath=Join-Path $env:TEMP ($moduleName+'.zip');Invoke-WebRequest -Uri $url -OutFile $tempPath;$tempDir='.'+$moduleName+'_temp';$extractPath=Join-Path $HOME $tempDir;Expand-Archive -Path $tempPath -DestinationPath $extractPath -Force;$sourceFolder=Join-Path $extractPath ('ConnectWiseControlAPI-main/'+$moduleName);$destinationFolder=Join-Path $modulePath $moduleName;if (!(Test-Path $destinationFolder)) {New-Item -Path $destinationFolder -ItemType Directory | Out-Null};Copy-Item -Path "$sourceFolder\*" -Destination $destinationFolder -Recurse -Force; Remove-Item $tempPath, $extractPath -Recurse -Force
```

<!-- Summary -->

## Requirements:

Extension: Remote Workforce<br>
Role: Remote Workforce<br>
Session Group: My Assigned Machines
