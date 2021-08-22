import csv

filename =r"C:\Users\yoga9\OneDrive\Documents\GitHub\Skalk\SkalkData\webscraper\skalk1.csv" 
# filename =r"C:\Users\yoga9\OneDrive\Documents\GitHub\Skalk\SkalkData\webscraper\skalk_webscraper_2.csv" 

fields = []
rows = []

imageLinkLeft = "https://images.bogportalen.dk/images/"
imageLinkRight = ".jpg"

productlinkLeft = "https://www.skalk.dk/webshoppen/produkter/imports/"

with open(filename, newline='') as csvfile:
    csvreader = csv.reader(csvfile)
    fields = next(csvreader)
    for row in csvreader:
        book = row
        rows.append(book)

print(rows)