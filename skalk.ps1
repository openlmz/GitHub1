# skalk.ps1
$filename='skalk1.csv'
$fullname =".\SkalkData\webscraper\$filename"
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
    if($medlemspris -eq "null"){
        $medlemspris = " "
    }
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
p {
    font-family: Calibri;
}
</style>
</head>
<body>
<table id='table'>
"@
$beginning |Out-File '.\file.html' -Append 
$count = -1
$count2=0
foreach ($row in $rows) {
    $count++
    $count2++
    if($count -eq 1000){
        break
    }
    if ($count % 4-eq 0){
        "<tr>" | Out-File '.\file.html' -Append
    }
    # style='width:200px; height:200px'
    "<div style='display:flex; flex-direction: row;' id='div'>" | Out-File '.\file.html' -Append
    if($count % 4-eq 2){
        "<td ><div style='width:150px; height:200px; padding-left: 20px; padding-bottom: 46px;'><img style='max-width:150px; max-height:200px'  id='image' src='"+$row[1]+"'></div></td>"  | Out-File '.\file.html' -Append
    } else {
        "<td ><div style='width:150px; height:200px; padding-bottom: 46px;'><img style='max-width:150px; max-height:200px'  id='image' src='"+$row[1]+"'></div></td>"  | Out-File '.\file.html' -Append
    }
        "<td ><div style='width:200px; height:200px; display:flex; flex-direction:column; display:block;'>" | Out-File '.\file.html' -Append
                "<p style='font-weight: bold;' id='title'>"+$row[2]+"</p>"  | Out-File '.\file.html' -Append 
                "<p id='isbn'>"+$row[0]+"</p>"  | Out-File '.\file.html' -Append 
                "<p id='m_price'>"+$row[3]+"</p>"  | Out-File '.\file.html' -Append 
                "<p id='price'>"+$row[4]+"</p>"  | Out-File '.\file.html' -Append 
            "</div></td>" | Out-File '.\file.html' -Append
    "</div>" | Out-File '.\file.html' -Append 
    if ($count2 % 4 -eq 0){
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
