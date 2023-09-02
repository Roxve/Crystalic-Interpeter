require "./tokenizer.cr";

puts "Welcome to The Crystalic*Interpeter"

while true 
  print(">>");
  STDOUT.flush
  code : String = gets || "0"
  tokenizer = Tokenizer.new(code)
  tokenized = tokenizer.tokenize
  puts tokenized
end


