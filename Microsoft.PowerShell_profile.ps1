Set-Alias -Name gd -Value Get-Date
# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}
oh-my-posh init pwsh | Invoke-Expression
Import-Module posh-git
Import-Module Terminal-Icons
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\craver.omp.json" | Invoke-Expression

Import-Module DockerComposeCompletion
Import-Module yarn-completion
Import-Module npm-completion

# PowerShell parameter completion shim for the dotnet CLI
Register-ArgumentCompleter -Native -CommandName dotnet -ScriptBlock {
     param($commandName, $wordToComplete, $cursorPosition)
         dotnet complete --position $cursorPosition "$wordToComplete" | ForEach-Object {
            [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
         }
 }

if ($host.Name -eq 'ConsoleHost') {
  Set-PSReadLineOption -EditMode Windows
  
  Set-PSReadLineOption -PredictionViewStyle ListView
  # Set-PSReadLineOption -PredictionViewStyle InkineView
  # Set-PSReadLineKeyHandler -Chord "Ctrl+RightArrow" -Function ForwardWord
}

$modules = @(
  "DockerComposeCompletion",
  "yarn-completion",
  "npm-completion",
  "posh-git",
  "Terminal-Icons"
);


function Update-ProfileModules {
  $modules | % { Update-Module -Name $_ };
  Update-Module PowerShellGet -Force;
}
function Install-ProfileModules {
  $modules | % { Install-Module -Name $_ };
}
