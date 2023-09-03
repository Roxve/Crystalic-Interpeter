require "../parser/AST.cr";
require "./main.cr";
require"./values.cr"

# since we only do math if you want to make this a programming lang
# you have to spilt this method
def eval_binary_expr(expr : Expr) : RuntimeVal
  expr = expr.as BinaryExpr;
  results : RuntimeVal = mk_NULL();
  lhs = Interpeter.evaluate(expr.left)
  rhs = Interpeter.evaluate(expr.right)

  if lhs.type != "num" && rhs.type != "num" 
    puts "excepted left hand of num and righ hand of num in binary expr\nat => line:#{expr.right.line}, colmun:#{expr.right.colmun}"
    return results;
  end

  lhs = lhs.as(NumVal); rhs = rhs.as(NumVal);
  case expr.operator 
    when '+'
      results = mk_NUM(lhs.value + rhs.value);
    when '-'
      results = mk_NUM(lhs.value - rhs.value);
    when '*'
      results = mk_NUM(lhs.value * rhs.value);
    when '/'
      results = mk_NUM(lhs.value / rhs.value);
    when '^'
      results = mk_NUM(lhs.value ** rhs.value);
    else
      puts "err"
  end
  return results
end
