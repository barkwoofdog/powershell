(get-content .\hostlist.txt | Select-Object -skip 1) | Set-Content .\hostlist.txt #skips first line of txt file (adds redundant line to CSV)
(Get-Content .\hostlist.txt -Encoding UTF8) | ForEach-Object {$_ -replace '"',''} | Out-File ".\hostlistFix.txt" -Encoding UTF8 #removes quotations from OG txt file and outputs to new txt that can be read properly



$result=@()
$inputFile = Get-Content .\hostlistFix.txt

Remove-Item ".\hostlist.txt" #gets rid of OG hostlist so nobody gets confuzzled

foreach ($Name in $inputFile) #iterates through txt file to perform A Record lookups for matching IP
{ $ipHost = "" | Select-Object Name,IPAddress 
try 
{
        $dnsRecord = Resolve-DnsName $NameRemove-Item ".\hostlist.txt"  -ErrorAction Stop | Where-Object {$_.Type -eq 'A'}        
        $ipHost.Name = $Name 
        $ipHost.IPAddress = ($dnsRecord.IPAddress -join '; ')        
}
catch {        
        $ipHost.Name = $Name        
        $ipHost.IPAddress = ''   
}
    $result += $ipHost}
    return $result | Export-Csv "hostnameLookupLog.csv" -NoTypeInformation #exports CSV for your convenience
