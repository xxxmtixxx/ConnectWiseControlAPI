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

This is a fork of ChrisTaylorCodes' and Luke-Williams9 CWC API module.

https://github.com/xxxmtixxx/ConnectWiseControlAPI/blob/master/Examples/CreateNewUser.ps1
The ConnectWise Control User Provisioning script is an automation tool designed to create new users and assign them to machines in ConnectWise Control. The script prompts for new user details, sets server variables, and defines the user's role. It then secures the user's password, installs and imports the necessary API module, and connects to the ConnectWise Control API. After creating the new user, it retrieves a list of machines/sessions, identifies the correct machine using its SessionID, and assigns the new user to that machine. If the machine isn't found, the script stops to prevent incorrect assignments. This efficient process streamlines user provisioning in ConnectWise Control.

<!-- Summary -->

## [DOWNLOAD](https://github.com/xxxmtixxx/ConnectWiseControlAPI/archive/refs/heads/master.zip)

 The module can be installed by unzipping the master zip into one of your powershell modules folder, or by running the following one-liner:

```powershell
$documentsPath=[Environment]::GetFolderPath('MyDocuments');$url='https://github.com/xxxmtixxx/ConnectWiseControlAPI/archive/refs/heads/master.zip';$moduleName='ConnectWiseControlAPI';$modulePath=Join-Path $documentsPath 'WindowsPowerShell\Modules';$tempPath=Join-Path $env:TEMP ($moduleName+'.zip');Invoke-WebRequest -Uri $url -OutFile $tempPath;$tempDir='.'+$moduleName+'_temp';$extractPath=Join-Path $HOME $tempDir;Expand-Archive -Path $tempPath -DestinationPath $extractPath -Force;$sourceFolder=Join-Path $extractPath ('ConnectWiseControlAPI-master/'+$moduleName);$destinationFolder=Join-Path $modulePath $moduleName;if (!(Test-Path $destinationFolder)) {New-Item -Path $destinationFolder -ItemType Directory | Out-Null};Copy-Item -Path "$sourceFolder\*" -Destination $destinationFolder -Recurse -Force
```
