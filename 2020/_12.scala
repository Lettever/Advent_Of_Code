class Position(var x : Int, var y : Int):
    def +(pos2 : Position) = Position(x + pos2.x, y + pos2.y) 
    def *(num : Int) = Position(x * num, y * num)
    def -(pos2 : Position) = this + (pos2 * (-1))
    def sum() = x + y
    def abs() = Position(x.abs, y.abs)

class Ferry(var pos : Position, var dir : Char):
    override def toString(): String = f"${pos.x} ${pos.y} $dir"
    def move(str : String) =
        val length = str.drop(1).toInt
        pos += {
                str(0) match
                case 'N' => Position(0, length)
                case 'E' => Position(length, 0)
                case 'S' => Position(0, -length)
                case 'W' => Position(-length, 0)
                case 'F' => dir match
                    case 'N' => Position(0, length)
                    case 'E' => Position(length, 0)
                    case 'S' => Position(0, -length)
                    case 'W' => Position(-length, 0)
            }            
 
    def rotate(str : String) = 
        val compass = Array('N', 'E', 'S', 'W')
        var index = compass.indexOf(dir) + {
            str(0) match
                case 'R' => str.drop(1).toInt / 90
                case 'L' => -str.drop(1).toInt / 90
        }
        while(index < 0) a += 4
        while(index >= 4) a -= 4
        dir = compass(index)

@main def AoC() =
    println("part1 " + part1())
    println("part2 " + part2())

def part1() : Int =
    val ferry = Ferry(Position(0, 0), 'E')    
    for line <- io.Source.fromFile("input.txt").getLines() do
        line(0) match
            case 'N' | 'S' | 'E' | 'W' | 'F' => ferry.move(line)
            case 'L' | 'R' => ferry.rotate(line)
    manhattan_distance(ferry.pos, Position(0, 0))

def part2() : Int =
    val waypoint = Ferry(Position(10, 1), '\u0000')    
    val ferry = Ferry(Position(0, 0), 'E')    
    for line <- io.Source.fromFile("input.txt").getLines() do
        line(0) match
            case 'N' | 'E' | 'S' | 'W' => waypoint.move(line)
            case 'L' | 'R' => println("TODO: Rotation")
            case 'F' => println("TODO: Forward")
    manhattan_distance(ferry.pos, Position(0, 0))

extension (num : Int)
    def in_range(min : Int, max : Int) = min <= num && num <= max

def manhattan_distance(pos1 : Position, pos2 : Position) : Int = (pos1 - pos2).abs().sum()
