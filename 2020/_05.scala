import scala.language.implicitConversions

@main def AoC() = 
    println("part1 " + part1())
    println("part2 " + part2())

def part1() : Int = io.Source.fromFile("input.txt").getLines().map(x => seatId(x)).max

def part2() : Int =
    val seats = io.Source.fromFile("input.txt").getLines()
    .map(x => seatId(x)).toArray.sortInPlace()
    seats.zip(seats.tail).find {case (x, y) => y - x == 2}.get(0) + 1

def row(str : String) : Int = str.foldLeft(0)((acc, ch) => acc * 2 + (ch == 'B'))
def column(str: String) : Int = 7 - str.foldLeft(0)((acc, ch) => acc * 2 + (ch == 'L'))
def seatId(str : String) : Int = row(str slice(0, 7)) * 8 + column(str slice(7, 10))

implicit def conv(b : Boolean) : Int = if (b) 1 else 0