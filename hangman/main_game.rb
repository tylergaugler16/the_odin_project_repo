require_relative("hangman")

Shoes.app :title => "Hangman" do 

end
while(true)
	puts "Do you want to play hangman?(y/n"
	reply=gets.chomp
	if(reply=="y") 
	 	h= Hangman.new
	else
		break
	end
end