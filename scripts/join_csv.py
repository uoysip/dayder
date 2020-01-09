#
# Concatenates all individual stock time-series datasets into one csv file
# where "Symbol" and "Date" headers can be used together to create a key for any specific record
# 
import glob
import csv

# open the output file to write to
with open('../data/all-stocks.csv', 'w', newline='') as f_output:
    csv_output = csv.writer(f_output)
    # write the CSV header at the top of the file
    csv_output.writerow(["Symbol", "Date", "Open", "High", "Low", "Close", "Volume", "OpenInt"])

    for filename in glob.glob('*.txt'):
        with open(filename, newline='') as f_input:
            csv_input = csv.reader(f_input)
            filename = filename.partition(".")[0]
            # skip the first line...
            next(csv_input, None)
            for row in csv_input:
                row.insert(0, filename)
                csv_output.writerow(row)
