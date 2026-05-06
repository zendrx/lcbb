require "./cli/fetch"
require "./cli/list"
require "./cli/verify"
    def show_help
     text = <<-STRING
      welcome to the llcb help message
      -v shows the current llcb version
      -h shows this help message
      -fetch this downloads the challenge you would like to take
      -list lists all challenges available
      -verify commplies and runs your code
      STRING
    end

    args = ARGV
    if args.empty?
     puts " Usage: lccb [list|fetch|verify|submit] [options]"
     puts ""
     puts "Commands:"
     puts " you passed no commands use -h"
     end
     command = args[0]
     case command
     when "list"
      level = args[1]
        puts " Listing #{level} challenges.."
        list_challenges(level)
      when "fetch"
       if args.size < 2
        puts " Error: please specify challenge Id"
        puts " Usage: lcbb fetch hello_world"
        end
        challenge_id = args[1]
        puts "fetching #{challenge_id}.."
        get_challenge(challenge_id)
      when "verify"
      if args.size < 2
       puts "Error: please specify a challenge ID"
       exit
     end
     id = args[1]
     verify(id)
     when "help"
       puts "#{show_help}"
     end
