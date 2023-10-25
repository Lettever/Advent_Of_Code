import scala.util.boundary, boundary.break

@main def AoC() = 
    println("part1 " + solve(1))
    println("part2 " + solve(2))

def solve(part : Int) : Int =
    val isPart1 = (part == 1)
    val map = Map(
        "byr" -> validate_byr, "iyr" -> validate_iyr,
        "eyr" -> validate_eyr, "hgt" -> validate_hgt,
        "hcl" -> validate_hcl, "ecl" -> validate_ecl,
        "pid" -> validate_pid
    )
    io.Source.fromFile("input.txt").getLines().foldLeft(0, 0) {
        case ((total, sum), line) =>
            if line.isEmpty() then (total + (sum == 7).toInt(), 0)
            else (total, sum + line.split(" ").filter(x => x.take(3) != "cid").count(x => isPart1 || map(x.take(3))(x.drop(4))))
    }(0)

extension (b : Boolean) def toInt() = if (b) then 1 else 0
extension (num : Int) def in_range(min : Int, max : Int) = min <= num && num <= max

def validate_byr(str : String) : Boolean = str.toInt.in_range(1920, 2002)

def validate_iyr(str : String) : Boolean = str.toInt.in_range(2010, 2020)

def validate_eyr(str : String) : Boolean = 
    str.length() match
        case 4 => str.toInt.in_range(2020, 2030)
        case _ => false

def validate_hgt(str : String) : Boolean =
    val unit = str.takeRight(2)
    val number = if str.dropRight(2).isEmpty then 0 else str.dropRight(2).toInt 
    unit match
        case "cm" => number.in_range(150, 193)
        case "in" => number.in_range(59, 76)
        case _ => false

def validate_hcl(str : String) : Boolean =
    if(str(0) != '#') then return false
    str.count("0123456789abcdef".contains(_)) == 6

def validate_ecl(str : String) : Boolean = str match
    case "amb" | "blu" | "brn" | "gry" | "grn" | "hzl" | "oth" => true
    case _ => false

def validate_pid(str : String) : Boolean = str.length == 9