function Invoke-GuacamoleAPIRequest {
    param (
        [Parameter(Mandatory=$true)] [ValidateNotNullOrEmpty()] [string]$APIEndpoint,
        [Parameter(Mandatory=$false)] [ValidateNotNullOrEmpty()] $Body,
        [Parameter(Mandatory=$false)] [ValidateNotNullOrEmpty()] [string]$Methode = "Get",
        [Parameter(Mandatory=$false)] [ValidateNotNullOrEmpty()] [string]$ContentType = "application/json"
    )

    $URI = "$($Script:GuacamoleConnection.BaseURL)/$APIEndpoint"
    Write-Debug "$Methode`:$URI"

    if([string]::IsNullOrEmpty($body)){
        $res = Invoke-RestMethod -URi $URI `
            -Headers @{"Guacamole-Token" = $Script:GuacamoleConnection.GetToken()} `
            -Method $Methode `
            -ContentType $ContentType
    }else{
        $body = ConvertTo-Json $body -Compress
        Write-Debug "Body: $body"
        #Write-Debug $body
        $res = Invoke-RestMethod -URi $URI `
            -Headers @{"Guacamole-Token" = $Script:GuacamoleConnection.GetToken()}  `
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