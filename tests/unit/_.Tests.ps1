$path = $MyInvocation.MyCommand.Path
$src = (Split-Path -Parent -Path $path) -ireplace '[\\/]tests[\\/]unit', '/src/'
Import-Module "$($src)/Pode.psm1" -Force

Describe 'Exported Functions' {
    It 'Have Parameter Descriptions' {
        $funcs = (Get-Module Pode).ExportedFunctions.Values.Name
        $found = @()

        foreach ($func in $funcs) {
            $params = (Get-Help -Name $func -Detailed).parameters.parameter
            foreach ($param in $params) {
                if (!$param.Description) {
                    $found += "$($func): $($param.Name)"
                }
            }
        }

        $found | Should Be @()
    }
}