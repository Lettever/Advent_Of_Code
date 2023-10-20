@main def AoC() =
    val (a, b) = parse("striped orange bags contain 1 vibrant green bag, 5 plaid yellow bags, 1 drab magenta bag.")
    println(a)
    b.foreach(println(_))
    println("part1 " + part1())
    println("part2 " + part2())

def part1() : Int =
    val lines = io.Source.fromFile("input.txt").getLines().toArray
    -1

def part2() : Int =
    val lines = io.Source.fromFile("input.txt").getLines().toArray
    -1

def parse(str : String) : (String, Array[String]) =
    str match
        case s"$adjectives bags contain $str." => (adjectives, str.split(", "))
        case _=> ("", Array.empty[String])
    