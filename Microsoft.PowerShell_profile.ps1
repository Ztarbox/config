Set-Alias -Name gd -Value Get-Date
# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}
Import-Module posh-git
Import-Module oh-my-posh
Import-Module Terminal-Icons
Set-PoshPrompt craver

#Import-Module DockerComposeCompletion
Import-Module yarn-completion
Import-Module npm-completion

# PowerShell parameter completion shim for the dotnet CLI
Register-ArgumentCompleter -Native -CommandName dotnet -ScriptBlock {
     param($commandName, $wordToComplete, $cursorPosition)
         dotnet complete --position $cursorPosition "$wordToComplete" | ForEach-Object {
            [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
         }
 }

if ($host.Name -eq 'ConsoleHost')
{
  Import-Module PSReadLine
  Set-PSReadLineOption -PredictionSource History
  Set-PSReadLineOption -PredictionViewStyle ListView
  Set-PSReadLineOption -EditMode Windows
  Set-PSReadLineKeyHandler -Chord "Ctrl+RightArrow" -Function ForwardWord
}

$modules = @(
  "DockerComposeCompletion",
  "yarn-completion",
  "npm-completion",
  "posh-git",
  "oh-my-posh",
  "Terminal-Icons"
);


function Update-ProfileModules {
  $modules | % { Update-Module -Name $_ };
  Update-Module PSReadLine -AllowPrerelease;
  Update-Module PowerShellGet -Force;
}
function Install-ProfileModules {
  $modules | % { Install-Module -Name $_ };
  Install-Module PSReadLine -AllowPrerelease;
}
