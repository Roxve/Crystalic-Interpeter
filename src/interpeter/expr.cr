require "../parser/AST.cr";
require "./main.cr";
require"./values.cr"

# since we only do math if you want to make this a programming lang
# you have to spilt this method
def eval_binary_expr(expr : Expr) : RuntimeVal
  expr = expr.as BinaryExpr;
  results : RuntimeVal = mk_NULL();
  lhs = Interpeter.evaluate(expr.left).as(NumVal)
  rhs = Interpeter.evaluate(expr.right).as(NumVal)
  case expr.operator 
    when '+'
      results = mk_NUM(lhs.value + rhs.value);
    when '-'
      results = mk_NUM(lhs.value - rhs.value);
    when '*'
      results = mk_NUM(lhs.value * rhs.value);
    when '/'
      results = mk_NUM(lhs.value / rhs.value);
    else
      puts "err"
  end
  return results
end
