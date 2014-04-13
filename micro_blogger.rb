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
end

if __FILE__ == $0
  blogger = MicroBlogger.new
  blogger.tweet("".ljust(140, "z"))
end
