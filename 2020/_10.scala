@main def AoC() = 
    println("part1 " + part1())
    println("part2 " + part2())

def part1() : Int =
    val numbers = {
        val temp = Array(0) ++ io.Source.fromFile("input.txt").getLines().map(_.toInt).toArray.sorted
        temp :+ temp.max + 3
    }
    val difference = numbers.zip(numbers.tail).map((x, y) => y - x)
    difference.count(_ == 1) * difference.count(_ == 3)

def part2() : Long =
    val numbers = {
        val temp = Array(0) ++ io.Source.fromFile("input.txt").getLines().map(_.toInt).toArray.sorted
        temp :+ temp.max + 3
    }
    val cumSum = Array.fill(numbers.max + 1) { 0L }
    for i <- numbers do cumSum(i) = 1L
    val range = (0 until numbers.max).reverse
    for i <- range do
        if cumSum(i) != 0 then cumSum(i) = cumSum(i + 1) + cumSum(i + 2) + cumSum(i + 3)
    cumSum(0)