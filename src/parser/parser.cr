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

  def except(correct_type : Type, msg : String)
    if at().type != correct_type
      puts msg + "\nat => line:#{at().line}, colmun:#{at().colmun}";
    end
    return take();
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
    return parse_additive_expr;
  end

  # handles add and minus exprs 1 + 1,1 - 1
  def parse_additive_expr() : Expr
    left : Expr = parse_multipicative_expr;
    while at().value == '+' || at().value == '-'
      operator = take().value;
      right = parse_multipicative_expr;

      left = BinaryExpr.new(left, right, operator, @@line, @@colmun);
    end
    return left;
  end


  def parse_multipicative_expr() : Expr
    left : Expr = parse_primary_expr;
    while at().value == '*' || at().value == '/' || at().value == '%'
      operator = take().value;
      
      right = parse_primary_expr;

      left = BinaryExpr.new(left, right, operator, @@line, @@colmun);
    end
    return left;
  end



  def parse_primary_expr() : Expr 
    case at().type 
      when Type::Num
        num = Num.new(take().value.to_f,@@line,@@colmun);
        return num;
      when Type::Operator
        if at().value != '-' && at().value != '+'
            puts "error cannot use operator '#{at().value}' without vaild left hand side\nat => line:#{@@line}, colmun:#{@@colmun}";
            return Null.new(@@line, @@colmun);
        end
        operator = take.value;
        num = parse_expr;
        return OneHandBinaryExpr.new(num, operator, @@line, @@colmun);
      else
        puts "error unexcepted token found while parsing\ngot => type:#{at().type},value:#{at().value}"
        take;
        return Null.new(@@line, @@colmun);
    end
end
end
