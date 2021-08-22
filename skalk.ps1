# skalk.ps1
$filename='skalk1.csv'
$fullname ="C:\Users\yoga9\OneDrive\Documents\GitHub\Skalk\SkalkData\webscraper\$filename"
# $fullname ='C:\Users\yoga9\OneDrive\Documents\GitHub\Skalk\SkalkData\webscraper\skalk1.csv'
# filename =r"C:\Users\yoga9\OneDrive\Documents\GitHub\Skalk\SkalkData\webscraper\skalk_webscraper_2.csv" 

$fields = [System.Collections.ArrayList]::new()
$rows = [System.Collections.ArrayList]::new()

$imageLinkLeft = "https://images.bogportalen.dk/images/"
$imageLinkRight = ".jpg"

$productlinkLeft = "https://www.skalk.dk/webshoppen/produkter/imports/"
Write-Host $filename

$filecontent=Get-Content -Path $fullname

Write-Host breakd

$file = Import-Csv -Path  $fullname
#.\input.csv 
foreach ($line in $file)
{
    $prod=$line[0].'produktlink-href'
    $isbn=$prod.substring(50,13)
    $imageLink = $imageLinkLeft + $isbn + $imageLinkRight
    $title=$line[0].Title
    $medlemspris = $line[0].Members_price
    $pris = $line[0].Price
    $row = @($isbn, $imageLink, $title, $medlemspris, $pris)
    [void]$rows.Add($row)
}

# Set-Content -Path '.\file.html' -Value $rows -Encoding UTF8

$htmlfile = Out-File '.\file.html' 
$beginning=
@"
<html>
<head>
<title>Skalk</title>
</head>
<body>
<table id='table' style='width:100%'>
"@
$beginning |Out-File '.\file.html' -Append 
$count = 0
foreach ($row in $rows) {
    $count++
    if($count -eq 5){
        break
    }
    "<div id='div'>" | Out-File '.\file.html' -Append 
    "<tr>" | Out-File '.\file.html' -Append 
        "<td><h3 id='title'>"+$row[2]+"</h3></td>"  | Out-File '.\file.html' -Append 
        "<td><img id='image' src='"+$row[1]+"'></td>"  | Out-File '.\file.html' -Append 
        "<td><p id='isbn'>"+$row[0]+"</p></td>"  | Out-File '.\file.html' -Append 
        "<td><p id='m_price'>"+$row[3]+"</p></td>"  | Out-File '.\file.html' -Append 
        "<td><p id='price'>"+$row[4]+"</p></td>"  | Out-File '.\file.html' -Append 
    "</tr>" | Out-File '.\file.html' -Append 
    "</div>" | Out-File '.\file.html' -Append 
}
$ending=
@"
</table>
</body>
</html>
"@     
$ending |Out-File '.\file.html' -Append 
