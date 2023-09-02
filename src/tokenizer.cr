enum Type
  Operator
  Num
end

class Token
  getter type;
  getter value;
  getter line;
  getter colmun;
  def initialize(@type : Type, @value : String | Char, @line : Int32,@colmun : Int32) 
  end
end


class Tokenizer
  @@code = [] of String
  @@tokens = [] of Token
  def initialize(code : String) 
    @@code = code.chars;
    @@tokens = [] of Token
  end
  @@line = 1;
  @@colmun = 0;


  def self.add(type : Type, value : String | Char) 
    token = Token.new(type,value,@@line, @@colmun) 
    @@tokens.push(token);
  end

  def self.isNum(x) 
    return "0123456789".includes? x;
  end

  def self.isSkippableChar(x)
    return " ;".includes? x;
  end
  

  def self.isOp(x) 
    return "+*/-%^".includes? x;
  end

  def self.take()
    @@colmun += 1;
    return @@code.shift();
  end
  
  def self.getLine() 
    if @@code[0] == "\n" 
      @@line += 1;
      @@colmun = 0;
      take
      return true;
    end
    return false;
  end

  def self.tokenize() 
    while @@code.size > 0
      if isSkippableChar(@@code[0])
        take
      elsif isNum(@@code[0]) 
        res : String = "";
        while @@code.size > 0 && isNum(@@code[0]) 
          res += take
        end
        add(Type::Num, res);
      elsif getLine() 
      # does nothing
      elsif isOp(@@code[0])
        add(Type::Operator, take);
      else 
        puts "unknown char '#{@@code[0]}' at line:#{@@line},colmun:#{@@colmun}";
        take;
      end
    end
    return @@tokens;
  end
end
