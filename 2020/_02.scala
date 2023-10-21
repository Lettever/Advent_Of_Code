@main def main() =
    println("part 1: " + solve(part1))
    println("part 2: " + solve(part2))
    
def solve(func : (String, Char, Int, Int) => Boolean) : Int =
    io.Source.fromFile("input.txt").getLines().toArray.count(
    _ match
        case s"$num1-$num2 $letter: $str" =>
            func(str, letter(0), num1.toInt, num2.toInt)
    )

def part1(str : String, ch : Char, min : Int, max : Int) : Boolean =
    min <= str.count(_ == ch) && str.count(_ == ch) <= max
def part2(str : String, ch : Char, index1 : Int, index2 : Int) : Boolean =
    (str(index1 - 1) == ch) ^ (str(index2 - 1) == ch)
