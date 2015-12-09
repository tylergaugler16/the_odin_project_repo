require 'socket'
require 'json'

host= 'localhost' #web server
port=2000
path="/index.html" 	#the file we want

puts "Do you want to make a GET or POST recquest?"
method= gets.chomp.downcase

if method == "get" then
request = "GET #{path} HTTP/1.0\r\n\r\n"		#http GET request of the file we want
else
puts "Please enter your name: "
name= gets.chomp
puts "Please enter your email: "
email=gets.chomp
	end
viking_json = {:viking => {:name => "#{name}", :email => "#{email}"}}.to_json
path="/thanks.html"
request= "POST #{path} HTTP/1.0\r\nContent-Type:application/json\r\nContent-Length: #{viking_json.size}\r\n\r\n#{viking_json}"	
socket= TCPSocket.open(host,port)	#connect to the server

socket.print(request)				#send the ruquest

while line= socket.gets
	puts line
	end


