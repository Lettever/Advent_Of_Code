@main def AoC() = 
    println("part1 " + part1())
    println("part2 " + part2())

def part1() : Int =
    val lines = io.Source.fromFile("input.txt").getLines().toArray
    val visited = new Array[Boolean](lines.length)
    var index = 0
    var acc = 0
    while(!visited(index))
        visited(index) = true
        parse(lines(index)) match
            case ("acc", num) =>
                acc += num
                index += 1
            case ("jmp", num) =>
                index += num
            case _ => index += 1
    println(lines(index))
    println(index)
    acc

def part2() : Int =
    val lines = io.Source.fromFile("input.txt").getLines().toArray
    -1

def parse(str : String) : (String, Int) = 
    str match
        case s"$op $num" => (op, num.toInt)
        case _ => println(str); assert(false)