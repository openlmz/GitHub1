import csv

filename = "skalk1.csv"

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