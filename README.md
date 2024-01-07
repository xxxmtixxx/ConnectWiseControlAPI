<h1 align="center">
  <br>
  <img src=".\Media\control-horiz-master.webp" alt="logo" width = 75% ></a>
  <br>
  ConnectWise Control API
  <br>
</h1>


<p align="center">
    <a href="ConnectWiseControlAPI_Functions.md">List of Functions</a> •
    <a href="./Examples">Examples</a> •
    <a href="#install">Install</a> •
</p>

<h4 align="center">

This is a PowerShell wrapper for ConnectWise Control

</h4>

<!-- Summary -->

This is a fork of ChrisTaylorCodes' and Luke-Williams9 CWC API module.



<!-- Summary -->


## [Install](https://github.com/xxxmtixxx/ConnectWiseControlAPI/archive/refs/heads/master.zip)

 The module can be installed by unzipping the master zip into one of your powershell modules folder, or by running the following one-liner:

```powershell
$documentsPath=[Environment]::GetFolderPath('MyDocuments');$url='https://github.com/xxxmtixxx/ConnectWiseControlAPI/archive/refs/heads/master.zip';$moduleName='ConnectWiseControlAPI';$modulePath=Join-Path $documentsPath 'WindowsPowerShell\Modules';$tempPath=Join-Path $env:TEMP ($moduleName+'.zip');Invoke-WebRequest -Uri $url -OutFile $tempPath;$tempDir='.'+$moduleName+'_temp';$extractPath=Join-Path $HOME $tempDir;Expand-Archive -Path $tempPath -DestinationPath $extractPath -Force;$sourceFolder=Join-Path $extractPath ('ConnectWiseControlAPI-master/'+$moduleName);$destinationFolder=Join-Path $modulePath $moduleName;if (!(Test-Path $destinationFolder)) {New-Item -Path $destinationFolder -ItemType Directory | Out-Null};Copy-Item -Path "$sourceFolder\*" -Destination $destinationFolder -Recurse -Force
```

## Requirements

* Now supports MFA! - <a href="https://github.com/xxxmtixxx/ConnectWiseControlAPI/blob/master/Examples/Connect_MFA.ps1">Connecting with MFA</a>

* Requires your Control server to use https.



