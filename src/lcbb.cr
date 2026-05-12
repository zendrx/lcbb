require "./cli/fetch"
require "./cli/list"
require "./cli/verify"

def show_help
  puts <<-STRING
    Welcome to the lcbb help message
    -v shows the current lcbb version
    -h shows this help message
    fetch [challenge_id] downloads the challenge you would like to take
    list [level] lists all challenges available
    verify [challenge_id] compiles and runs your code and compares output
    help shows this help message
  STRING
end

def show_version
  puts "lcbb version 0.1.0"
end

args = ARGV

if args.empty?
  puts "Usage: lcbb [list|fetch|verify|help] [options]"
  puts ""
  puts "Commands:"
  puts "  list [level]     - List available challenges for a level (beginner, intermediate, advanced)"
  puts "  fetch [id]       - Download a challenge by ID"
  puts "  verify [id]      - Verify your solution for a challenge"
  puts "  help             - Show this help message"
  puts "  -h               - Show this help message"
  puts "  -v               - Show version information"
  exit
end

command = args[0]

case command
when "list"
  if args.size < 2
    puts "Error: please specify a level"
    puts "Usage: lcbb list [beginner|intermediate|advanced]"
    exit 1
  end
  level = args[1]
  puts "Listing #{level} challenges..."
  list_challenges(level)

when "fetch"
  if args.size < 2
    puts "Error: please specify challenge ID"
    puts "Usage: lcbb fetch hello_world"
    exit 1
  end
  challenge_id = args[1]
  puts "Fetching #{challenge_id}..."
  get_challenge(challenge_id)

when "verify"
  if args.size < 2
    puts "Error: please specify a challenge ID"
    puts "Usage: lcbb verify hello_world"
    exit 1
  end
  id = args[1]
  verify(id)

when "help", "-h"
  show_help

when "-v"
  show_version

else
  puts "Error: unknown command '#{command}'"
  puts ""
  puts "Available commands: list, fetch, verify, help"
  puts "Use 'lcbb help' for more information"
  exit 1
end
