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

  def dm(target, message)
    puts "Trying to send #{target} this direct message: "
    puts message
    str = "d #{target} #{message}"
    screen_names = @client.followers.collect { |follower| follower.screen_name }
    if screen_names.include? target
      tweet(str)
    else
      puts "Error: You can only DM people who you follow!"
    end
  end

  def followers_list
    @client.followers.collect { |follower| follower.screen_name }
  end

  def spam_my_follower(message)
    f_list = followers_list
    f_list.each { |follower| dm(follower, message) }
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
        when 'dm' then dm(parts[1], parts[2..-1].join(" "))
        when 'spam' then spam_my_follower(parts[1..-1].join(" "))
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
