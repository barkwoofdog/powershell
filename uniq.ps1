#trying to emulate uniq from BASH without flags
#This script will parse through a text file and search for strings that occur only once
#Not pretty but it works

#Grabs the file you want unique strings found from
$file = Read-Host "Please input the path to the file you want parsed: "

#Utilizes Regex to get rid of non-words and numbers. Groups objects and counts them then outputs to a staging file
(Get-Content $file) -Split '\W' -Split '\d' | Group-Object | Out-File -FilePath .\prelim.txt

#Utilizes regex to remove all instances of not 1. Should filter everything but base10 that starts with 1 may slip through (ex: 1251) (i think)
(Get-Content .\prelim.txt) | Where-Object {$_ -notmatch '[2-9]'} | Where-Object {$_ -notmatch "10|11"} | Set-Content -Path '.\result.txt' 

#Removes staging file for housekeeping purposes
Remove-Item ".\prelim.txt"


"
Finished. Have a great day!
"
