# Save to a CSV file
csv_file = File.join(__dir__, 'positions.csv')
def save
  CSV.open(csv_file, 'wb') do |csv|
    csv << %w[date bonds stocks]
    csv << [Time.mktime(Time.now.year, Time.now.month, Time.now.day).to_i, total_bonds, total_stocks]
  end
end

def seek_last_row
csv_file = File.join(__dir__, 'positions.csv')
f = File.open(csv_file)
f.seek(-2, IO::SEEK_END) # Begin at penultimate position (the last position is the blank line at the end of the file)
while f.pos.positive?
  if f.getc == "\n" # Stop at the next newline character
    last_line = f.read # Set newline
    break
  else
    f.pos -= 2 # Comb through the file
  end
end
row = CSV.parse_line(last_line) # Parse last line
return row
end

last_row = seek_last_line
