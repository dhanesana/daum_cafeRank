require 'open-uri'

page_num = 1

while page_num < 501 # First 500 Pages
  item_num = 0
  page = Nokogiri::HTML(open("http://top.cafe.daum.net/_c21_/category_list?type=sub&page=#{page_num}&subcateid=85&cateid=5"))
  while item_num < 15
    name = page.css('td.cafename a substring')[item_num].text
    link = page.css('td.cafename')[item_num].css('a').first['href']
    members = page.css('td.member')[item_num].text.gsub(/,/, '').to_f
    members = 0 if members < 1
    Cafe.create(title: name, score: members, url: link)
    item_num += 1
  end
  page_num += 1
end
