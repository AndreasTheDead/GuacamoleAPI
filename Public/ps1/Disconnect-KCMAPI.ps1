function Disconnect-KCMAPI {
    $uri = "$($script:KCMConnection.BaseURL)/api/session"
    Write-Debug "Request URL = $URI"
    $Header = @{"Guacamole-Token" = $Script:KCMConnection.GetToken()}

    try{
        Invoke-RestMethod -Uri $uri -Headers $Header -Method Delete -SkipCertificateCheck:$($script:KCMConnection.SkipCertificateCheck)
        $script:KCMConnection = $null
        Write-Host "Successfully Disconnected from KCM Server" -ForegroundColor Green
    }catch{
        Write-Host "Error While disconnecting from KCM Server"
        Write-Host "Error: $_"
    }
}
