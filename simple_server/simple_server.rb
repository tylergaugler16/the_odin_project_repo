require 'socket'
require 'json'

server= TCPServer.open("localhost",2000)	#Socket to listen on port 2000. returns a TCPServer object

#loop waits for a client to make a request
loop{

	client=server.accept #accepts conection of client accept is just an instance method of the TCPServer class. It waits around for a connection, and when it gets a connection, it returns the TCPSocket representing that connection
	request = client.recv(1000).split("\r\n")
	header = request.first.split("\n")
  	body= request[1..-1]
  	method = header[0].split(" ")[0]
  	path= header[0].split(" ")[1]
  	version= header[0].split(" ")[2]

  	begin 
  		f=File.open(Dir.pwd+"#{path}").read  if File.exist?(Dir.pwd+"#{path}")
  		if method=="GET" 
  			client.puts "#{version} 200 OK \n#{Time.now.ctime}\nContent-Type:text-html\nContent-length: #{f.size}\n\n"
		f.each do |line|
			client.puts line
			end
		elsif method== "POST" 
			params= JSON.parse(body[-1])
             data= "<li>Name: #{params['viking']['name']}</li>"\
				  "<li>Email: #{params['viking']['email']}</li>"
			 length= f.gsub('<%= yield %>', data).length
			 puts f.gsub('<%= yield %>', data)
			 response= "#{version} 200 OK\n#{Time.now.ctime}\nContent-Type:text-html\nContent-length: #{length}\n\n#{f.gsub('<%= yield %>', data)}"
			 client.print response
		else
			client.puts "#{version} 404 Not Found \n#{Time.now.ctime}\n\nThe File You Are Looking For Does Not Exist"
		end
		
		
	end
  	
 
	
	
	
	
	client.close #disconnect from the client
}



	


	

