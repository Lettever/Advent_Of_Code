import scala.util.boundary, boundary.break
@main def AoC() = 
    println("part1 " + part1())
    println("part2 " + part2())

def part1() : Int = calculate(io.Source.fromFile("input.txt").getLines().toArray)(0)

def part2() : Int =
    val lines = io.Source.fromFile("input.txt").getLines().toArray
    boundary:
        for i <- 0 until lines.length do
            val a = parse(lines(i))
            if a(0) == "nop" then
                lines(i) = f"jmp ${a(1)}"
                val b = calculate(lines)
                if b(1) then break(b(0))
                lines(i) = f"nop ${a(1)}"
            else if a(0) == "jmp" then
                lines(i) = f"nop ${a(1)}"
                val b = calculate(lines)
                if b(1) then break(b(0))
                lines(i) = f"jmp ${a(1)}"
        -1

def parse(str : String) : (String, Int) =
    val parts = str.split(" ")
    (parts(0), parts(1).toInt)

def calculate(commands : Array[String]) : (Int, Boolean) =
    val visited = new Array[Boolean](commands.length)
    var index = 0
    var acc = 0
    while(index < commands.length && !visited(index))
        visited(index) = true
        parse(commands(index)) match
            case ("acc", num) =>
                acc += num
                index += 1
            case ("jmp", num) =>
                index += num
            case _ => index += 1
    (acc, index >= commands.length)