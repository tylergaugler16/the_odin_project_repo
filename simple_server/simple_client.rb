require 'socket'

hostname='127.0.0.1'
port =2000

s=TCPSocket.open(hostname,port) #creates a connection to hostname(localhost) on port(2000)
path="/index.html"
request = "GET #{path} HTTP/1.0\r\n\r\n"
s.print(request)

while line=s.gets do	#read lines from the socket
	 puts line.chop		
end

s.close		#close the connection