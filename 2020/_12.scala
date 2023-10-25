import scala.math.cos
import scala.math.sin

@inline final val PI = java.lang.Math.PI

class Position(var x : Int, var y : Int):
    def +(pos2 : Position) = Position(x + pos2.x, y + pos2.y) 
    def *(num : Int) = Position(x * num, y * num)
    def -(pos2 : Position) = this + (pos2 * (-1))
    def sum() = x + y
    def abs() = Position(x.abs, y.abs)

class Ferry(var pos : Position, var dir : Char):
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
    def rotate(str : String, center : Position = Position(0, 0)) = 
        val trig = (
            if str(0) == 'L' then (
                cos(str.drop(1).toDouble * PI / 180).toInt,
                sin(str.drop(1).toDouble * PI / 180).toInt
            )
            else (
                cos(-str.drop(1).toDouble * PI / 180).toInt,
                sin(-str.drop(1).toDouble * PI / 180).toInt
            )
        )
        this.pos -= center
        val xnew = pos.x * trig(0) - pos.y * trig(1)
        val ynew = pos.x * trig(1) + pos.y * trig(0)
        pos.x = xnew + center.x
        pos.y = ynew + center.y

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
            case 'L' | 'R' => waypoint.rotate(line, ferry.pos)
            case 'F' => 
                val distance = waypoint.pos - ferry.pos
                ferry.pos    += distance * line.drop(1).toInt
                waypoint.pos += distance * line.drop(1).toInt
    manhattan_distance(ferry.pos, Position(0, 0))

def manhattan_distance(pos1 : Position, pos2 : Position) : Int = (pos1 - pos2).abs().sum()
