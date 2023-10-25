@main def AoC() = 
    println("part1 " + part1())
    println("part2 " + part2())
    
def part1() : Int =
    io.Source.fromFile("input.txt").getLines().foldLeft(0, "") {
        case ((total, string), line) =>
            if line.isEmpty() then (total + string.distinct.length(), "")
            else (total, string + line)
    }(0)

def part2() : Int =
    io.Source.fromFile("input.txt").getLines().foldLeft(0, Array.empty[String]) {
        case ((sum, array), line) =>
            if line.isEmpty() then 
                val flattened = array.mkString
                val charsCount = flattened.distinct.toCharArray.map(x => (x, flattened.count(_ == x)))
                (sum + charsCount.count((_, x) => x % array.length == 0), Array())
            else (sum, array :+ line)
    }(0)

    //val charsCount = string.distinct.toCharArray.map(x => (x, string.count(_ == x)))
    //counts the frequency of all characters in a string