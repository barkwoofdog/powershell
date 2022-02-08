#This script compares a single column of data in a CSV. The data does not have to be in order
$file1= Read-Host -Prompt "path to compare file (any differences from baseline file?) " # File you want comparisons made from
$file2= Read-Host -Prompt "path to baseline file (compared to file above)" #Baseline file. The one you want comparisons made to
$column = Read-Host -Prompt "Enter Column to compare" #Column Name (Hostname)

$file1Import = Import-Csv $file1 #both these line import the csv of the stored filepath from file1&2 variables
$file2Import = Import-Csv $file2


Compare-Object $file1Import $file2Import -Property $column | #what is in quotations is the name of the column you are comparing
    Where SideIndicator -eq "<=" | #take this line out if you want the differences in BOTH
    Select $column | #yet again must match the name of the column you are wanting to compare
    Export-Csv -Path ".\hostlist.txt" -NoType #exports the results to a text file
