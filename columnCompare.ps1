#This script compares a single column of data in a CSV. The data does not have to be in order
$file1= Read-Host -Prompt "Please input the path of the file you want compared to your Baseline file: " | Import-Csv # File that is compared to baseline. Any differences in this compared to baseline? SEE DOC FOR EXPLANATION
$file2= Read-Host "Please input the path to Baseline file: " | Import-Csv #Baseline File 
$column = Read-Host "please type the column you would like compared: "

Compare-Object $file1 $file2 -Property $column | #what is in quotations is the name of the column you are comparing
    Where SideIndicator -eq "<=" | #take this line out if you want the differences in BOTH
    Select $column | #yet again must match the name of the column you are wanting to compare

Export-Csv ".\differencesOG.txt" -NoType #exports the results to a text file WITH Quotations

(Get-Content .\differencesOG.txt -Encoding UTF8) | ForEach-Object {$_ -replace '"',''} | Out-File ".\differences.txt" -Encoding UTF8 #removes quotations from OG txt file for easy copy paste into next step

Remove-Item ".\differencesOG.txt" #deletes OG text file for housecleaning reasons
