function Disconnect-GuacamoleAPI {
    $uri = "$($script:GuacamoleConnection.BaseURL)/api/session"
    Write-Debug "Request URL = $URI"
    $Header = @{"Guacamole-Token" = $Script:GuacamoleConnection.GetToken()}

    try{
        Invoke-RestMethod -Uri $uri -Headers $Header -Method Delete
        $script:GuacamoleConnection = $null
        Write-Host "Successfully Disconnected from Guacamole Server" -ForegroundColor Green
    }catch{
        Write-Host "Error While disconnecting from Guacamole Server"
        Write-Host "Error: $_"
    }
}
