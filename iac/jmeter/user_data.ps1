<powershell>
# jmeter download
wget https://dlcdn.apache.org//jmeter/binaries/apache-jmeter-5.5.zip -o apache-jmeter-5.5.zip

# jmeter unzip
Expand-Archive C:\Users\Administrator\Desktop\apache-jmeter-5.5.zip -DestinationPath C:\Users\Administrator\Desktop

# jdk8 download
wget https://cdn.azul.com/zulu/bin/zulu8.68.0.21-ca-jdk8.0.362-win_x64.zip -o zulu8.68.0.21-ca-jdk8.0.362-win_x64.zip

# jdk8 unzip
Expand-Archive C:\Users\Administrator\Desktop\zulu8.68.0.21-ca-jdk8.0.362-win_x64.zip -DestinationPath C:\Users\Administrator\Desktop

# Add java_home to path environment
# https://poshcode.gitbook.io/powershell-faq/src/getting-started/environment-variables
# $Env:Path += [IO.Path]::PathSeparator + $pwd
# function Add-Path($Path) {
#    $Path = [Environment]::GetEnvironmentVariable("PATH", "Machine") + [IO.Path]::PathSeparator + $Path
#    [Environment]::SetEnvironmentVariable( "Path", $Path, "Machine" )
# }
</powershell>