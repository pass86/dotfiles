mklink %USERPROFILE%\_vimrc %USERPROFILE%\dotfiles\.vimrc
mklink %USERPROFILE%\_ideavimrc %USERPROFILE%\dotfiles\.ideavimrc

mkdir %USERPROFILE%\Documents\PowerShell
mklink %USERPROFILE%\Documents\PowerShell\Profile.ps1 %USERPROFILE%\dotfiles\Profile.ps1

mkdir %APPDATA%\JetBrains\Shared\vAny
mklink %APPDATA%\JetBrains\Shared\vAny\GlobalSettingsStorage.DotSettings %USERPROFILE%\dotfiles\GlobalSettingsStorage.DotSettings
