require 'jumpstart_auth'

class MicroBlogger
  attr_reader :client

  def initialize
    puts "Initializing..."
    @client = JumpstartAuth.twitter
  end

  def tweet(message)
    if message.size > 140
      puts "Tweet is too big!!"
    else
      @client.update(message)
    end
  end

  def run
    command = ""
    while command != "q"
      puts ""
      printf "Enter command: "
      input = gets.chomp
      parts = input.split
      command = parts[0]

      case command
        when 'q' then puts "Goodbye!"
        when 't' then tweet(parts[1..-1].join(" "))
        else
          puts "Sorry, I don't know how to #{command}"
        end
      end
    end
end

if __FILE__ == $0
  blogger = MicroBlogger.new
  blogger.run
end
