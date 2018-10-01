require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    student_cards = doc.css(".student-card")
    student_cards.collect {|card| {name: card.css(".card-text-container h4").text, location: card.css(".card-text-container p").text, profile_url: card.css("a").href}}
  end

  def self.scrape_profile_page(profile_url)
    attributes = {}
    doc = Nokogiri::HTML(open(profile_url))
    sm_links = doc.css(".social-icon-container a")
    sm_links.each do |link|
      attributes[:twitter] = link.href if link.href.include?("twitter")
      attributes[:linkedin] = link.href if link.href.include?("linkedin")
      attributes[:github] = link.href if link.href.include?("github")
      attributes[:blog] = link.href
    end
    attributes[:profile_quote] = doc.css(".profile_quote").text
    attrubutes[:bio] = doc.css(".description-holder p").text
    attributes
  end

end
