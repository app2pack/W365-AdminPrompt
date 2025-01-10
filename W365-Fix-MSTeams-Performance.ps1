# Function to enable Teams Media Optimization
Function Enable-TeamsMediaOptimization {
    Write-Host "Starting Teams Media Optimization configuration..." -ForegroundColor Green

    # Path to the Teams registry key
    $registryPath = "HKLM:\SOFTWARE\Microsoft\Teams"
    $propertyName = "IsWVDEnvironment"
    $propertyValue = 1

    # Check if the Teams registry key exists
    if (-not (Test-Path $registryPath)) {
        Write-Host "Teams registry key not found. Creating it..." -ForegroundColor Yellow
        New-Item -Path $registryPath -Force
    } else {
        Write-Host "Teams registry key already exists." -ForegroundColor Cyan
    }

    # Create or update the registry value
    New-ItemProperty -Path $registryPath -Name $propertyName -PropertyType DWORD -Value $propertyValue -Force
    Write-Host "Registry key updated successfully!" -ForegroundColor Green

    # Verify the value
    $currentValue = (Get-ItemProperty -Path $registryPath).$propertyName
    if ($currentValue -eq $propertyValue) {
        Write-Host "Teams Media Optimization is successfully enabled." -ForegroundColor Green
    } else {
        Write-Host "Failed to enable Teams Media Optimization." -ForegroundColor Red
    }
}

# Call the function
Enable-TeamsMediaOptimization
