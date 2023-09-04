require "./parser/parser.cr";
require "./interpeter/main.cr"
require "./parser/AST.cr";
puts "Welcome to The Crystalic*Interpeter\nType 'exit' to exit!"

while true 
  print(">>");
  STDOUT.flush
  code : String = gets || "0"
  if code.upcase.includes? "EXIT"
    exit
  end
  

  parser = Parser.new(code);
  ast = parser.productAST();
  run = Interpeter.eval_program(ast.as(Program));
  puts run.value
end


