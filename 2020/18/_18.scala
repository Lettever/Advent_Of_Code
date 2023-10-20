import scala.collection.mutable.Queue
import scala.collection.mutable.Stack

@main def AoC() = 
    println("part1 " + part1())
    println("part2 " + part2())
    val a = toRpn("1 - 2 + 3")
    
    println(a)
def part1() : Int =
    val lines = io.Source.fromFile("input.txt").getLines().toArray
    -1

def part2() : Int =
    val lines = io.Source.fromFile("input.txt").getLines().toArray
    -1

def toRpn(equation : String) : String = 
    val tokens = equation.split(" ")
    val postFix = new Queue[String]
    val operators = new Stack[String]
    for token <- tokens do
        if token.isNumber then postFix += token
        else if token == ")" then
            while operators.top != "(" do postFix += operators.pop()
            operators.pop()
        else
            while !operators.isEmpty && token(0).precedence >= operators.top(0).precedence do
                postFix += operators.pop()
            operators += token
    while !operators.isEmpty do postFix += operators.pop()
    postFix.toArray.mkString(" ")

extension (str : String) def isNumber : Boolean = str matches """\d+"""
extension (ch : Char) def precedence : Int =
    ch match
        case '+' | '-' => 0
        case '*' | '/' => 1    