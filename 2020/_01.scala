import scala.util.boundary, boundary.break
@main def main() =
    println("part1: " + part1())
    println("part2: " + part2())

def part1() : Int =
    val numbers = io.Source.fromFile("input.txt").getLines.map(line => line.toInt).toArray
    boundary:
        for i <- 0     until numbers.length
            j <- i + 1 until numbers.length do
            if(numbers(i) + numbers(j) == 2020)
                break (numbers(i) * numbers(j))

def part2() : Int =
    val numbers = io.Source.fromFile("input.txt").getLines.map(line => line.toInt).toArray
    boundary:
        for i <- 0     until numbers.length
            j <- i + 1 until numbers.length
            k <- i + 2 until numbers.length do
                if(numbers(i) + numbers(j) + numbers(k) == 2020)
                    break (numbers(i) * numbers(j) * numbers(k))
