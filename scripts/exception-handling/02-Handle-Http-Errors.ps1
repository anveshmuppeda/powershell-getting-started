<#
.SYNOPSIS
    Demonstrates how to handle HTTP errors (like 404 Not Found) when calling an API
    using Invoke-RestMethod in a way that is compatible with Windows PowerShell 5.1.
#>
$apiUrl = "https://api.github.com/this-user-does-not-exist"

try {
    Write-Host "Attempting to send a request to: $apiUrl"
    # -ErrorAction Stop is crucial to make the error terminating so it can be caught.
    $response = Invoke-RestMethod -Uri $apiUrl -Method Get -ErrorAction Stop
    Write-Host "Request successful!"
    $response | ConvertTo-Json
}
catch [System.Net.WebException] { # This is the exception type for web errors in PowerShell 5.1
    Write-Host "Caught a Web Exception!"

    if ($_.Exception.Response) {
        $statusCode = [int]$_.Exception.Response.StatusCode
        $statusDescription = $_.Exception.Response.StatusDescription

        Write-Host "Status Code: $statusCode"
        Write-Host "Status Description: $statusDescription"

        if ($statusCode -ge 400 -and $statusCode -lt 500) {
            Write-Host "This is a client-side error (4xx)."
        }
        elseif ($statusCode -ge 500 -and $statusCode -lt 600) {
            Write-Host "This is a server-side error (5xx)."
        }
    }
    else {
        Write-Host "An error occurred, but no HTTP response was received (e.g., DNS failure, no network)."
        Write-Host "Error Message: $($_.Exception.Message)"
    }
}
catch {
    Write-Host "An unexpected, non-web-related error occurred:"
    Write-Host $_.Exception.Message
}
finally {
    Write-Host "Finished API interaction attempt."
}