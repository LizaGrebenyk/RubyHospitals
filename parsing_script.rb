require 'nokogiri'
require 'csv'
require 'open-uri'

url = 'https://www.newsweek.com/rankings/worlds-best-hospitals-2023'
html = URI.open(url, 'User-Agent' => 'Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:47.0) Gecko/20100101 Firefox/47.0').read

doc = Nokogiri::HTML(html)

CSV.open('hospitals.csv', 'wb', write_headers: true,
         headers: ["Rank", "Publication name", "Country", "City", "State (US only)"]) do |csv|
  # рядки
  doc.css('tbody tr').each do |row|
    # кожен стовпець в рядку
    rank = row.at_css('.col1').text.strip
    name = row.at_css('.col2').text.strip
    country = row.at_css('.col3').text.strip
    city = row.at_css('.col4').text.strip
    state = row.at_css('.col5').text.strip

    # запис даних в csv
    csv << [rank, name, country, city, state]
  end
end
