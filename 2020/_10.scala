@main def AoC() = 
    println("part1 " + part1())
    println("part2 " + part2())

def part1() : Int =
    val numbers = Array(0) ++ io.Source.fromFile("input.txt").getLines().map(_.toInt).toArray.sorted
    val difference = numbers.zip(numbers.tail ++ Array(numbers.max + 3)).map((x, y) => y - x)
    difference.count(_ == 1) * difference.count(_ == 3)

def part2() : Long =
    val numbers = Array(0) ++ io.Source.fromFile("input.txt").getLines().map(_.toInt).toArray.sorted
    val array = Array.fill(numbers.max + 4) { 0L }
    for i <- numbers ++ Array(numbers.max + 3) do array(i) = 1L
    val range = (0 to numbers.max).reverse
    for i <- range do
        if array(i) != 0 then array(i) = array(i + 1) + array(i + 2) + array(i + 3)
    array(0)