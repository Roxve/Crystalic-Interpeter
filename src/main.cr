require "./tokenizer.cr";
require "./parser/parser.cr";
require "./interpeter/main.cr"
require "./parser/AST.cr";
puts "Welcome to The Crystalic*Interpeter"

while true 
  print(">>");
  STDOUT.flush
  code : String = gets || "0"
  tokenizer = Tokenizer.new(code)
  tokenized = tokenizer.tokenize
  parser = Parser.new(tokenized);

  ast = parser.productAST();
  run = Interpeter.eval_program(ast.as(Program));
  puts run.value
end


