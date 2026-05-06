require "http/client"
require "json"

def list_challenges(level : String)
  url = "https://api.github.com/repos/zendrx/challenges/contents/#{level}"
  response = HTTP::Client.get(url)
  if response.status_code == 200
    body = JSON.parse(response.body)
      puts "Available #{level} challenges:"
      puts "--------------------------"
      body.as_a.each do |file|
        name = file["name"].as_s.gsub(".md", "")
        puts " - #{name}"
      end
  else
    puts "Failed to list challenges: #{response.status_code}"
  end
end
