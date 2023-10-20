@main def AoC() = 
    println("part1 " + part1())
    println("part2 " + part2())
    val a = to_bin(11)
    println(a)
    val b = to_dec(a)
    println(b)

def part1() : Int =
    val lines = io.Source.fromFile("input.txt").getLines().toArray
    -1

def part2() : Int =
    val lines = io.Source.fromFile("input.txt").getLines().toArray
    -1

def to_bin(n_ : Int) : String = 
    val binary = Array.fill(36) { '0' }
    var i = 35
    var n = n_
    while(n != 0)
        binary(i) = if n % 2 == 0 then '0' else '1'
        n /= 2
        i -= 1
    binary.mkString

def to_dec(str : String) : Long = str.foldLeft(0 : Long)((x, y) => 2 * x + (y == '1').toInt)

extension (b : Boolean) def toInt = if b then 1 else 0