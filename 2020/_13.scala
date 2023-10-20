import scala.util.boundary, boundary.break
@main def AoC() = 
    println("part1 " + part1())
    println("part2 " + part2())

def part1() : Int =
    val lines = io.Source.fromFile("input.txt").getLines().toArray
    lines(1).split(",").filter(_ != "x").map(_.toInt).map(x => (x, x - lines(0).toInt % x)).minBy(x => x(1)).prod

def part2() : Long =
    /*
    val lines = io.Source.fromFile("input.txt").getLines().toArray
    val a = lines(1).split(",").zipWithIndex.filter(x => x(0) != "x")
    a.foreach(i => println(i))
    */
    chinese_theorem(
        Array(37, 41, 433, 23, 17, 19, 29, 593, 13),
        Array(0, 14, 396, 1, 14, 1, 21, 525, 10))

extension (tuple : (Int, Int)) def prod = tuple(0) * tuple(1)

// returns x where (a * x) % b == 1
def mul_inv(a : Long, b : Long) : Long =
    var a_ = a
    var b_ = b
    var b0 = b
    var t : Long = 0
    var q : Long = 0
    var x0 : Long = 0
    var x1 : Long = 1
    if b == 1 then return 1
    while a_ > 1 do
        q = a_ / b_
        t = b_
        b_ = a_ % b_
        a_ = t
        t = x0
        x0 = x1 - q * x0
        x1 = t
    if x1 < 0 then x1 += b0
    x1
def chinese_theorem(numbers : Array[Int], remainders : Array[Int]) : Long =
    val prod = numbers.map(_.toLong).reduce((x, y) => x * y)
    var sum : Long = 0
    for i <- 0 until numbers.length do
        val p : Long = prod / numbers(i)
        sum += remainders(i) * mul_inv(p, numbers(i)) * p
    sum % prod

/*
    t % 37  == 0 - 0
    t % 41  == 0 - 27
    t % 433 == 0 - 37
    t % 23  == 0 - 45
    t % 17  == 0 - 54
    t % 19  == 0 - 56
    t % 29  == 0 - 66
    t % 593 == 0 - 68
    =>
    t % 37  == 0
    t % 41  == 14
    t % 433 == 396
    t % 23  == 1
    t % 17  == 14
    t % 19  == 1
    t % 29  == 21
    t % 593 == 525
    t % 13 == 10
*/
