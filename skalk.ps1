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
<style>
body {
    
}
</style>
</head>
<body>
<table id='table'>
"@
$beginning |Out-File '.\file.html' -Append 
$count = 0
foreach ($row in $rows) {
    $count++
    if($count -eq 30){
        break
    }
    if ($count % 4-eq 0){
        "<tr>" | Out-File '.\file.html' -Append
    }
    "<div style=';display:flex; flex-direction: row; border:1px;' id='div'>" | Out-File '.\file.html' -Append
        "<td><img style='width:100%; height: 100%' id='image' src='"+$row[1]+"'></td>"  | Out-File '.\file.html' -Append 
        "<td><div style='display:flex; flex-direction:column;'>" | Out-File '.\file.html' -Append
            "<h3 id='title'>"+$row[2]+"</h3>"  | Out-File '.\file.html' -Append 
            "<p id='isbn'>"+$row[0]+"</p>"  | Out-File '.\file.html' -Append 
            "<p id='m_price'>"+$row[3]+"</p>"  | Out-File '.\file.html' -Append 
            "<p id='price'>"+$row[4]+"</p>"  | Out-File '.\file.html' -Append 
        "</div></td>" | Out-File '.\file.html' -Append
    "</div>" | Out-File '.\file.html' -Append 
    if ($count % 4-eq 0){
        "</tr>" | Out-File '.\file.html' -Append
    }
}
$ending=
@"
</table>
</body>
</html>
"@     
$ending |Out-File '.\file.html' -Append 
