# This script demonstrates the basic use of a try-catch-finally block.

try {
    Write-Host "In the 'try' block. Attempting a risky operation..."
    # This line will cause a "division by zero" error.
    $result = 1 / 0
    # This line will never be reached because the error above stops the 'try' block.
    Write-Host "This message will not be displayed."
}
catch {
    # This block executes when an error is caught in the 'try' block.
    Write-Host "In the 'catch' block. An error was caught!"
    Write-Host "Error Details: $($_.Exception.Message)"
}
finally {
    # This block executes regardless of whether an error occurred or not.
    # It's ideal for cleanup tasks.
    Write-Host "In the 'finally' block. This code always runs."
}

Write-Host "Script execution continues after the try-catch-finally block."