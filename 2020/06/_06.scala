@main def AoC() = 
    println("part1 " + part1())
    println("part2 " + part2())
    //val str = "hello"
    //val countsMap = str.distinct.toCharArray.map(x => (x, str.count(_ == x)))
    //counts the character in a string
    
def part1() : Int =
    var sum = 0
    var str = ""
    for line <- io.Source.fromFile("input.txt").getLines() do
        if line == "" then
            sum += str.distinct.length
            str = ""
        else
            str += line
    sum

def part2() : Int =
    var sum = 0
    var temp : Array[String] = Array()
    for line <- io.Source.fromFile("input.txt").getLines() do
        if line == "" then
            val flattened = temp.mkString
            val countsMap = flattened.distinct.toCharArray.map(x => (x, flattened.count(_ == x)))
            sum += countsMap.count((_, x) => x % temp.length == 0)
            temp = Array()
        else
            temp :+= line
    sum