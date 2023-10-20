import scala.util.boundary, boundary.break

@main def AoC() = 
    println("part1 " + part1())
    println("part2 " + part2())

def part1() : Long =
    val numbers = io.Source.fromFile("input.txt").getLines().map(_.toLong).toArray[Long]
    boundary:
        for i <- 0 until numbers.length - 25; j = numbers.length.min(i + 25) do
            if(two_sum(numbers, i, j, numbers(j)) == (-1, -1)) then break(numbers(j)) 
        -1  

def part2() : Long =
    val numbers = io.Source.fromFile("input.txt").getLines().map(_.toLong).toArray
    val invalid_number = 1124361034
    var (i, j) = (0, 1)
    var (i2, j2) = (0, 0)
    var max_slice = 0
    while(i < numbers.length && j < numbers.length) do
        val sum = numbers.slice(i, j + 1).sum
        if sum == invalid_number then
            if j + 1 - i > max_slice then
                max_slice = j + 1 - i
                i2 = i
                j2 = j
            j += 1
        else if(sum > invalid_number) then i += 1
        else if(sum < invalid_number) then j += 1
    val sliced = numbers.slice(i2, j2 + 1)
    sliced.min + sliced.max

def two_sum(array : Array[Long], left : Int, right : Int, num : Long) : (Int, Int) =
    boundary:
        for i <- left  until right
            j <- i + 1 until right do
                if(array(i) + array(j) == num) then break((i, j))
        (-1, -1)
