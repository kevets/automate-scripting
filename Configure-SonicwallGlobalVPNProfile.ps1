$TestResult = $true
# Configure Sonicwall Global VPN Profile
# Identifies if default profile is not set(could improve to compare to uploaded file and auto fix)
# Sets the DefaultFile path to the desired profile
# Flushes user level profiles, forcing defaults to be used

$DefaultFile = 'C:\Program Files\SonicWall\Global VPN Client\Default.rcf'
$UserData = 'C:\Users\*\AppData\Roaming\SonicWALL\Global VPN Client'

if (!(get-childitem $DefaultFile -ErrorAction silentlycontinue))
{
    Write-Warning 'Default connection profile not set!'
    $TestResult = $false
}
# You may add multiple tests
$TestResult



switch ($method) {
    "test" {
        # Used in Audit and Enforce Mode
        # You can output anything you want before this, but the last thing returned must be castable into a boolean (true or false)
        return $TestResult
    }
    "set" {
        # Perform action that will make the test return true the next time it runs
        $s1 = copy-item $ConnectionFile $DefaultFile -force
        remove-item $UserData -recurse -force
        return $s1
    }
    "get" {
        # You can return anything from here, used when in "Monitor" mode
        if (!$DefaultFile)
        {
            Write-Warning 'Default connection profile not set!'
            $TestResult = $false
        }
        # You may add multiple tests
        return $TestResult
    }
}