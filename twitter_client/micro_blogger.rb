require 'jumpstart_auth'

class MicroBlogger
	attr_reader :client

	def initialize
		puts "initializing MicroBlogger...."
		@client = JumpstartAuth.twitter
	end

	def tweet(message)
		if message.length <= 140 then
		@client.update(message)
		else
			puts "Message exceeds maximum length"
		end
	end

	def dm(target, message)
		puts "Trying to send #{target} this direct messaage:"
		puts message 
		screen_names= @client.followers.collect{|follower| @client.user(follower).screen_name}
		puts screen_names.inspect
		if screen_names.include?(target) then
		message= "d #{target} #{message}"
		tweet(message)
		else
			puts "Cannot send a message to #{target}. Need to be a follower."
		end
		
	end

	def followers_list
		screen_names=[]
		@client.followers.each do |follower|
		screen_names << @client.user(follower).screen_name
		end
		return screen_names
	end

	def spam_followers(message)
		puts message 
		followers_list.each do |follower|
			dm(follower,message)
		end
	end

	def last_tweet_list 
		
		friends=@client.friends
		friends = friends.map { |friend| @client.user(friend) }
		friends= friends.sort_by {|f| f.screen_name.downcase}
		
		friends.each do |friend|
			timestamp= friend.status.created_at
			puts "#{friend.screen_name} at #{timestamp.strftime("%A, %b %d %Y")} : "
			puts last_tweet = friend.status.text
		end
	end

	def run
		puts "Welcome to the JSL twitter client!"
		command=""
		while command != 'q'
			printf "Enter command:  "
			input = gets.chomp
			parts= input.split(" ")
			command=parts[0]
			case command
			when 'q' then puts "Goodbye!"
			when 't' then tweet(parts[1..-1].join(" "))
			when 'dm' then dm(parts[1], parts[2..-1].join(" "))
			when 'spam' then spam_followers(parts[1..-1].join(" "))
			when 'ltl' then last_tweet_list
			else
				puts "Sorry I dont know how to #{command}"
			end
		end
	end

	



end

micro= MicroBlogger.new
micro.run