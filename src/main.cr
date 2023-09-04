require "./parser/parser.cr";
require "./interpeter/main.cr"
require "./parser/AST.cr";
require "./interpeter/enviroments.cr";
require "readline"
puts "Welcome to The Crystalic*Interpeter\nType 'exit' to exit!"

while true 
  code : String = Readline.readline(">> ") || "0"
  if code.upcase.includes? "EXIT"
    exit
  end
  
  env = createEnv();

  parser = Parser.new(code);
  ast = parser.productAST();
  run = Interpeter.eval_program(ast.as(Program), env);
  puts run.value
end


