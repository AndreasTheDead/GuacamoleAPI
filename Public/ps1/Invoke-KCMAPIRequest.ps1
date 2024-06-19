function Invoke-KCMAPIRequest {
    param (
        [Parameter(Mandatory=$true)] [ValidateNotNullOrEmpty()] [string]$APIEndpoint,
        [Parameter(Mandatory=$false)] [ValidateNotNullOrEmpty()] $Body,
        [Parameter(Mandatory=$false)] [ValidateNotNullOrEmpty()] [string]$Methode = "Get",
        [Parameter(Mandatory=$false)] [ValidateNotNullOrEmpty()] [string]$ContentType = "application/json"
    )

    $URI = "$($Script:KCMConnection.BaseURL)/$APIEndpoint"
    Write-Debug "$Methode`:$URI"

    if([string]::IsNullOrEmpty($body)){
        $res = Invoke-RestMethod -URi $URI `
            -Headers @{"Guacamole-Token" = $Script:KCMConnection.GetToken()} `
            -Method $Methode `
            -ContentType $ContentType `
            -SkipCertificateCheck:$($script:KCMConnection.SkipCertificateCheck)
    }else{
        $body = ConvertTo-Json $body -Compress
        Write-Debug "Body: $body"
        #Write-Debug $body
        $res = Invoke-RestMethod -URi $URI `
            -Headers @{"Guacamole-Token" = $Script:KCMConnection.GetToken()}  `
            -Body $Body `
            -Method $Methode `
            -ContentType $ContentType `
            -SkipCertificateCheck:$($script:KCMConnection.SkipCertificateCheck)
    }

    if(![string]::IsNullOrEmpty($res)){
        return $res
    }else{
        return
    }
}