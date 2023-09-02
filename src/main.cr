require "./tokenizer.cr";

while true 
  print(">>");
  STDOUT.flush
  code : String = gets || "0"
  tokenizer = Tokenizer.new(code)
  puts Tokenizer.tokenize
end


