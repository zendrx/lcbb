require "http/client"

def verify(id : String)
  path = "solutions/#{id}.md"
  result = `crystal {path} 2>&1`
  if $?.success?
    puts " it compiles and runs successfully "
    puts " submitting to github..."
    puts " to view community solutions visit https://lcbb-solutions.netlify.app/solutions.html?challenge=#{id}"
    puts " "
  else
    puts " it does not compile or run successfully "
    puts result
  end
end
