require 'open-uri'

page_num = 1

while page_num < 500 # First 500 Pages
  unless Cafe.last.nil?
    break if Cafe.last.id > 9449
  end
  # Check Musician Cafes
  item_num = 0
  page = Nokogiri::HTML(open("http://top.cafe.daum.net/_c21_/category_list?type=sub&page=#{page_num}&subcateid=85&cateid=5"))
  while item_num < 15
    name = page.css('td.cafename a substring')[item_num].text
    link = page.css('td.cafename')[item_num].css('a').first['href']
    members = page.css('td.member')[item_num].text.gsub(/,/, '').to_f
    # members = 0 if members < 1
    @cafe = Cafe.where(url: link).first
    if @cafe
      @cafe.url = link
      @cafe.score = members
      @cafe.save
    else
      # Must have 1000+ members
      Cafe.create(title: name, score: members, url: link) if members > 999
    end
    item_num += 1
  end
  # Check Celebrity Cafes
  item_num = 0
  page = Nokogiri::HTML(open("http://top.cafe.daum.net/_c21_/category_list?type=sub&page=#{page_num}&subcateid=8A&cateid=5&scorebndry=0080715cchn&regionid="))
  while item_num < 15
    name = page.css('td.cafename a substring')[item_num].text
    link = page.css('td.cafename')[item_num].css('a').first['href']
    members = page.css('td.member')[item_num].text.gsub(/,/, '').to_f
    # members = 0 if members < 1
    @cafe = Cafe.where(url: link).first
    if @cafe
      @cafe.url = link
      @cafe.score = members
      @cafe.save
    else
      # Must have 1000+ members
      Cafe.create(title: name, score: members, url: link) if members > 999
    end
    item_num += 1
  end
  page_num += 1
end
