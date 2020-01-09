require "csv"
require "pp"
require "time"

data = Hash.new { |hash, key| hash[key] = []}

CSV.foreach("../data/all-stocks.csv", headers: true) do |row|
  symbol = "#{row["Symbol"].upcase}"
  date = Time.parse(row["Date"])
  value = "#{row["Close"]}"
  
  if row.key?("Date")
    print "ADDED: Symbol: #{symbol}, Date: #{date}, Value: #{value}\n"
    data[symbol].push([date.to_i, value.to_f]) # wrong?
  end
end


# open file for writing the data
f = File.open("../btsf/all_stocks.btsf","w")

#  header for the file
f.print [1, 4*4, 2*4, data.size].pack("L*")

# write time series data to file
data.each do |name, points|
  f.print [points.length, name.length].pack("L*")
  f.print name
  points.each do |d,v|
    f.print [d, v].pack("le")
  end
end
