$filename = .\DNS.txt # File in current working directory.
$csv_file = .\DNS_TO_IP.csv # File in current working directory

# Doing cleanup. We want to append to a fresh CSV.
Remove-Item –path $csv_file

# read and iterate over each line in $filename
foreach($line in Get-Content $filename) {
    try{
        $resolution = Resolve-DnsName -Name $line -ErrorAction Stop 
    } catch {
        # We set manual parameters for columns due to error resolving the name.
        $resolution.Name = $line
        $resolution.IPAddress = "Not Resolved"
        $resolution | select name, IPAddress | Export-Csv -Path $csv_file -Append 
    }
    # Write results to $csv_file
    $resolution | select name, IPAddress | Export-Csv -Path $csv_file -Append
}

