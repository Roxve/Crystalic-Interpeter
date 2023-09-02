abstract class Expr
  @@type : String = "Expr";
  @@line : Int32 = 1;
  @@colmun : Int32 = 0;
end


class Program 
  @@type = "Program";
  @body : Array(Expr) = [] of Expr;
  getter body;
  def initialize()
    @body = [] of Expr;
  end
end



class BinaryExpr < Expr
  @@type = "BinaryExpr";
  def initialize(@left : Expr, @right : Expr, @operator : Expr, line, colmun)
    @@line = line;
    @@colmun = colmun;
  end
end





class Num < Expr
  @@type = "Num";
  def initialize(@value : Int32, line, colmun) 
    @@line = line;
    @@colmun = colmun;
  end
end


class Null < Expr
  @@type = "Null";
  def initialize(line, colmun) 
    @@line = line;
    @@colmun = colmun
  end
end
