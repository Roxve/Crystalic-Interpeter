require "../parser/AST.cr";
require "./values.cr";
require "./expr.cr"
module Interpeter 
  @@line = 1;
  @@colmun = 0;
  def self.eval_program(prog : Program)
    last : RuntimeVal = mk_NULL();
    prog.body.each do |expr| 
      last = evaluate(expr);
    end

    return last;
  end

  def self.evaluate(expr : Expr) : RuntimeVal 
    @@line = expr.line;
    @@colmun = expr.colmun; 
    last : RuntimeVal = mk_NULL();
    case expr.type
    when "Program"
      last = eval_program(expr.as(Program));
    when "BinaryExpr"
      last = eval_binary_expr(expr);
    when "UnaryExpr"
      last = eval_unary_expr(expr.as(UnaryExpr));
    when "Num"
      last = mk_NUM(expr.as(Num).value);
    when "Null" 
      last = mk_NULL();
    else
      last = mk_NULL();
    end
    return last;
  end
end
