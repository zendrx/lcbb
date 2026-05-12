require "http/client"

def verify(id : String)
  solution_path = "solutions/#{id}.cr"
  challenge_path = "challenges/#{id}.md"
  
  unless File.exists?(solution_path)
    puts "Error: Solution file not found at #{solution_path}"
    puts "Please create your solution at #{solution_path}"
    exit 1
  end
  
  unless File.exists?(challenge_path)
    puts "Error: Challenge file not found at #{challenge_path}"
    puts "Please fetch the challenge first: lcbb fetch #{id}"
    exit 1
  end
  
  expected = extract_expected_output(challenge_path)
  
  if expected.nil?
    puts "Error: No expected output marker found in #{challenge_path}"
    puts "Add <!-- expected: YOUR_OUTPUT --> to the challenge file"
    exit 1
  end
  
  result = `crystal run #{solution_path} 2>&1`
  
  if $?.success?
    actual = result.strip
    if actual == expected.strip
      puts "Verification passed. Output matches expected."
      puts ""
      puts "To view community solutions visit:"
      puts "https://lcbb-solutions.netlify.app/solutions.html?challenge=#{id}"
    else
      puts "Verification failed. Output does not match expected."
      puts ""
      puts "Expected output:"
      puts expected
      puts ""
      puts "Your output:"
      puts actual
    end
  else
    puts "Compilation or runtime error:"
    puts result
  end
end

def extract_expected_output(challenge_path : String) : String?
  content = File.read(challenge_path)
  
  if match = content.match(/<!-- expected: (.*?) -->/)
    return match[1]
  end
  
  nil
end
