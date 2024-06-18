function Connect-GuacamoleAPI {
    param (
        [pscredential]$credentials,
        #[string][ValidatePattern("(^(http(s)?:\/\/.)[-a-zA-Z0-9:./]{2,256}$)")]$BaseURL,
        [string][ValidateScript({$_ -match "(^(http(s)?:\/\/.)[-a-zA-Z0-9:./]{2,256}$)" -and $_ -notlike "*/" -and $_ -notlike "*/api*"})]$BaseURL,
        [string][ValidateSet("mysql","sqlserver","mysql")]$DataSource
    )
    $URI = "$BaseURL/api/tokens"
    Write-Debug "Request URL = $URI"

    $Body = @{
        "username" = $credentials.username
        "password" = $credentials.GetNetworkCredential().Password
    }

    try {
        $res = Invoke-RestMethod -URi $URI `
            -ContentType "application/x-www-form-urlencoded" `
            -Body $Body `
            -Method Post
        
        $script:GuacamoleConnection = [GuacamoleAPIConnection]::new()
        $script:GuacamoleConnection.BaseURL = $BaseURL
        $script:GuacamoleConnection.Token = (ConvertTo-SecureString $res.authToken -AsPlainText -Force)
        $script:GuacamoleConnection.DataSource = $res.dataSource
        Write-Debug "GuacamoleConnectionObject:"
        Write-Debug "BaseURL: $($script:GuacamoleConnection.BaseURL)"
        Write-Debug "DataSource: $($script:GuacamoleConnection.DataSource)"
        Write-Debug "Token: $($Script:GuacamoleConnection.GetToken())"
        Write-Host "Successfully Connected to Guacamole Server" -ForegroundColor Green
    }catch{
        Write-Host "Error While connectiong to Guacamole Server"
        Write-Host "Error: $_"
    }
}
