function Invoke-GuacamoleAPIRequest {
    param (
        [Parameter(Mandatory=$true)] [ValidateNotNullOrEmpty()] [string]$APIEndpoint,
        [Parameter(Mandatory=$false)] [ValidateNotNullOrEmpty()] $Body,
        [Parameter(Mandatory=$false)] [ValidateNotNullOrEmpty()] [string]$Methode = "Get",
        [Parameter(Mandatory=$false)] [ValidateNotNullOrEmpty()] [string]$ContentType = "application/json"
    )

    $URI = "$($Script:GuacamoleConnection.BaseURL)/$endpoint"
    Write-Debug "$Methode`:$URI"

    if([string]::IsNullOrEmpty($body)){
        $res = Invoke-RestMethod -URi $URI `
            -Headers @{"Guacamole-Token" = $token} `
            -Method $Methode `
            -ContentType $ContentType
    }else{
        $body = ConvertTo-Json $body -Compress
        Write-Debug "Body: $body"
        #Write-Debug $body
        $res = Invoke-RestMethod -URi $URI `
            -Headers @{"Guacamole-Token" = $token} `
            -Body $Body `
            -Method $Methode `
            -ContentType $ContentType
    }

    if(![string]::IsNullOrEmpty($res)){
        return $res
    }else{
        return
    }
}