<#
.SYNOPSIS
    Demonstrates how to handle common errors when reading a file, such as
    "File Not Found" and "Access Denied".
#>
$filePath = "C:\this-file-does-not-exist.txt"

try {
    Write-Host "Attempting to read content from: $filePath"
    # -ErrorAction Stop elevates non-terminating errors to terminating so they can be caught.
    $fileContent = Get-Content -Path $filePath -ErrorAction Stop
    Write-Host "File read successfully!"
    $fileContent | ForEach-Object { Write-Host "Line: $_" }
}
catch [System.IO.FileNotFoundException] {
    Write-Host "ERROR: The file was not found at the specified path."
    Write-Host "Please check if the file exists at: $filePath"
}
catch [System.UnauthorizedAccessException] {
    Write-Host "ERROR: Access denied."
    Write-Host "You do not have the required permissions to read the file: $filePath"
}
catch {
    Write-Host "An unexpected error occurred while reading the file."
    Write-Host $_.Exception.Message
}
finally {
    Write-Host "Finished file reading attempt."
}