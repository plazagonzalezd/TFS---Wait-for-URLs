﻿[cmdletbinding()]
param(
    [string]$serviceName,
    [string]$binaryPath,
    [string]$username,
    [string]$password,
    [string]$displayName,
    [string]$description,
    [string]$startUp,

    [string]$computerName,
    [string]$adminLogin,
    [string]$adminPass
    )
Import-Module .\createServiceTaskFunctions.psm1
$securePassword = ConvertTo-SecureString $adminPass -AsPlainText -Force
$creds = New-Object System.Management.Automation.PSCredential ($adminLogin, $securePassword)

Invoke-Command -Credential $creds `
               -ComputerName $computerName `
               -ScriptBlock ${function:Install-Service} `
               -ArgumentList @($serviceName, $binaryPath, $username, $password, $displayName, $description, $startUp)
