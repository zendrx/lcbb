require "http/client"
require "json"

MANIFEST_CONTENTS = {{read_file("src/manifest.json")}}

def get_challenge(id : String)
  manifest = JSON.parse(MANIFEST_CONTENTS)
  challenge_lvl = manifest[id]
  url = "https://raw.githubusercontent.com/zendrx/challenges/main/#{challenge_lvl}/#{id}.md"
  response = HTTP::Client.get(url)
  if response.status_code == 200
    markdown_content = response.body
    create_file(id, markdown_content)
  end
end

def create_file(id : String, content : String)
  unless Dir.exists?("challenges")
    Dir.mkdir("challenges")
  end
  File.write("challenges/#{id}.md", content)
  puts "Challenge saved as challenges/#{id}.md"
  puts "read the challenge at: file://challenges/#{id}.md"
end
