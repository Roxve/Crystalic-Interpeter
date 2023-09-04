enum Type
  Operator
  Num
  OpenParen
  CloseParen
  Err
  EOF
end

struct Token
  getter type;
  getter value;
  getter line;
  getter colmun;
  def initialize(@type : Type, @value : String | Char, @line : Int32,@colmun : Int32) 
  end
end


struct Tokenizer
  @@code = [] of String
  def initialize(code : String) 
    @@code = code.chars;
  end

  def code
    @@code
  end
  @@line = 1;
  @@colmun = 0;
  @current_token : Token = Token.new(Type::Err, "unknown", @@line, @@colmun);
  getter current_token

  def add(type : Type, value : String | Char) 
    token = Token.new(type,value,@@line, @@colmun) 
    @current_token = token;
  end

  def isNum(x) 
    return "01234.56789".includes? x;
  end

  def isSkippableChar(x)
    return " ;".includes?(x) || x == "\t";
  end
  
  def take()
    @@colmun += 1;
    return @@code.shift();
  end
  
  def getLine() 
    if @@code[0] == "\n" 
      @@line += 1;
      @@colmun = 0;
      take
      return true;
    end
    return false;
  end

  def tokenize() 
    while @@code.size > 0 && isSkippableChar(@@code[0])
      take
    end
    if @@code.size <= 0
      add(Type::EOF, "<EOF>");
      return @current_token;
    end

    case @@code[0]
    when '+','-','*','/','^'
      add(Type::Operator, take)
    when '0','1','2','3','4','5','6','7', '8', '9'
      res : String = "";
      while @@code.size > 0 && isNum(@@code[0])
        res += take
      end
      add(Type::Num, res)
    when '('
      add(Type::OpenParen, take)
    when ')'
      add(Type::CloseParen, take)
    else
      if getLine() 
      # does nothing
      else 
        puts "unknown char '#{@@code[0]}' at line:#{@@line},colmun:#{@@colmun}";
        add(Type::Err, take)
      end
    end
    return @current_token;
  end
end
