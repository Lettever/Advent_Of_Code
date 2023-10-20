//go to the right 3 and down one until you go off screen
//going off screen to the right loops you to the back 

val TREE = '#'

@main def AoC() = 
    println("part1 " + part1())
    println("part2 " + part2())

def part1() : Int = io.Source.fromFile("input.txt").getLines.toArray.tree(3, 1)

def part2() : Long =
    val map = io.Source.fromFile("input.txt").getLines.toArray
    map.tree(1, 1).toLong *
    map.tree(3, 1).toLong *
    map.tree(5, 1).toLong *
    map.tree(7, 1).toLong *
    map.tree(1, 2).toLong


extension (map : Array[String])
    def tree(x_vel : Int, y_vel : Int) : Int =
        var x = 0
        var y = 0
        var trees = 0
        while y < map.length do
            if map(y)(x) == TREE then trees += 1
            x = (x + x_vel) % map(0).length
            y += y_vel
        trees

