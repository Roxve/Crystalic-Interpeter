require "./AST.cr";
require "../tokenizer.cr";

class Parser
  def initialize(@Tokens : Array(Token)) 
  end
  @@line = 1;
  @@colmun = 0;
  def update() 
    @@line = @Tokens[0].line
    @@colmun = @Tokens[0].colmun
  end
  
  # updates line and colmun info and returns current token
  def at()
    update;
    return @Tokens[0];
  end

  def notEOF()
    return at().type != Type::EOF
  end

  def take() 
    update;
    return @Tokens.shift();
  end

  def productAST() : Program
    prog = Program.new;

    while notEOF 
      prog.body.push(parse_expr);
    end

    return prog;
  end

  # acts as a return to the first expr to parse
  def parse_expr() : Expr
    return parse_primary_expr;
  end

  def parse_primary_expr() : Expr 
    case at().type 
      when Type::Num
        num = Num.new(take().value.to_i,@@line,@@colmun);
        return num;
      else
        puts "error unexcepted token found while parsing\ngot => type:#{at().type},value:#{at().value}"
        take;
        return Null.new(@@line, @@colmun);
    end
  end
end
