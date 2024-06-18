function Connect-GuacamoleAPI {
    param (
        [pscredential][Parameter(Position=0,mandatory=$true)]$credentials,
        #[string][ValidatePattern("(^(http(s)?:\/\/.)[-a-zA-Z0-9:./]{2,256}$)")]$BaseURL,
        [string][Parameter(Position=1,mandatory=$true)][ValidateScript({$_ -match "(^(http(s)?:\/\/.)[-a-zA-Z0-9:./]{2,256}$)" -and $_ -notlike "*/" -and $_ -notlike "*/api*"})]$BaseURL,
        [string][Parameter(Position=2,mandatory=$false)][ValidateSet("mysql","sqlserver","postgresql","mysql-shared","sqlserver-shared","postgresql-shared")]$DataSource
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
        
        if($DataSource){
            if($DataSource -in $res.availableDataSources){
                $script:GuacamoleConnection.DataSource = $DataSource
            }else{
                Write-Error "Selected DataSource is not avalibale, falling back to Token respone source: $($res.dataSource)"
                $script:GuacamoleConnection.DataSource = $res.dataSource
            }
        }else{
            $script:GuacamoleConnection.DataSource = $res.dataSource
        }
        
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
