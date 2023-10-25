val TREE = '#'

@main def AoC() = 
    println("part1 " + part1())
    println("part2 " + part2())

def part1() : Long = io.Source.fromFile("input.txt").getLines.toArray.tree(3, 1)

def part2() : Long =
    val map = io.Source.fromFile("input.txt").getLines.toArray
    Array((1, 1), (3, 1), (5, 1), (7, 1), (1, 2)).
    map((x_vel, y_vel) => map.tree(x_vel, y_vel)).product

extension (map : Array[String]) def tree(x_vel : Int, y_vel : Int) : Long =
    (0 until map.length by y_vel).zipWithIndex.foldLeft(0) {
    case (trees, (y, index)) =>
        val x = (index * x_vel) % map(0).length
        if map(y)(x) == TREE then trees + 1 else trees
    }.toLong