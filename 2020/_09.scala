import scala.util.boundary, boundary.break

@main def AoC() = 
    println("part1 " + part1())
    println("part2 " + part2())

def part1() : Long =
    val numbers = io.Source.fromFile("input.txt").getLines().map(_.toLong).toArray[Long]
    boundary:
        for window <- numbers.sliding(26) do
            if two_sum(window) == (-1, -1) then break(window.last)
        -1

def part2() : Long =
    val numbers = io.Source.fromFile("input.txt").getLines().map(_.toLong).toArray
    val invalid_number = part1()
    var (left, right) = (0, 1)
    var (i2, j2) = (0, 0)
    var max_slice = 0
    while(left < numbers.length && right < numbers.length) do
        val sum = numbers.take(right).drop(left).sum
        if sum == invalid_number then
            if right + 1 - left > max_slice then
                max_slice = right + 1 - left
                i2 = left
                j2 = right
            right += 1
        else if(sum > invalid_number) then left  += 1
        else if(sum < invalid_number) then right += 1
    val sliced = numbers.take(j2).drop(i2)
    sliced.min + sliced.max

def two_sum(window : Array[Long]) : (Int, Int) = 
    require(window.length == 26)
    val target = window.last
    boundary:
        for i <- 0     until window.length - 1
            j <- i + 1 until window.length - 1 do
                if window(i) + window(j) == target then break((i, j))
        (-1, -1)
