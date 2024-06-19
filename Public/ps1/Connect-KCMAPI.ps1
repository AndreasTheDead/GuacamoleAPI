function Connect-KCMAPI {
    param (
        [pscredential][Parameter(Position=0,mandatory=$true)]$credentials,
        #[string][ValidatePattern("(^(http(s)?:\/\/.)[-a-zA-Z0-9:./]{2,256}$)")]$BaseURL,
        [string][Parameter(Position=1,mandatory=$true)][ValidateScript({$_ -match "(^(http(s)?:\/\/.)[-a-zA-Z0-9:./]{2,256}$)" -and $_ -notlike "*/" -and $_ -notlike "*/api*"})]$BaseURL,
        [string][Parameter(Position=2,mandatory=$false)][ValidateSet("mysql","sqlserver","postgresql","mysql-shared","sqlserver-shared","postgresql-shared")]$DataSource,
        [switch][Parameter(Position=3,mandatory=$false)]$SkipCertificateCheck
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
            -Method Post `
            -SkipCertificateCheck:$SkipCertificateCheck
        
        $script:KCMConnection = [KCMAPIConnection]::new()
        $script:KCMConnection.BaseURL = $BaseURL
        $script:KCMConnection.SkipCertificateCheck = $SkipCertificateCheck
        $script:KCMConnection.Token = (ConvertTo-SecureString $res.authToken -AsPlainText -Force)
        
        if($DataSource){
            if($DataSource -in $res.availableDataSources){
                $script:KCMConnection.DataSource = $DataSource
            }else{
                Write-Error "Selected DataSource is not avalibale, falling back to Token respone source: $($res.dataSource)"
                $script:KCMConnection.DataSource = $res.dataSource
            }
        }else{
            $script:KCMConnection.DataSource = $res.dataSource
        }
        
        Write-Debug "KCMConnectionObject:"
        Write-Debug "BaseURL: $($script:KCMConnection.BaseURL)"
        Write-Debug "DataSource: $($script:KCMConnection.DataSource)"
        Write-Debug "Token: $($Script:KCMConnection.GetToken())"
        Write-Host "Successfully Connected to KCM Server" -ForegroundColor Green
    }catch{
        Write-Host "Error While connectiong to KCM Server"
        Write-Host "Error: $_"
    }
}
