import scala.language.implicitConversions
import scala.util.boundary, boundary.break

@main def AoC() = 
    println("part1 " + part1())
    println("part2 " + part2()) //11 is wrong

def part1() : Int =
    var sum = 0
    var total = 0

    for line <- io.Source.fromFile("input.txt").getLines() do
        if(line == "")
            total += (sum == 7).toInt()
            sum = 0
        else
            for field <- line.split(" ") do
                if (field.slice(0, 3)) != "cid" then sum += 1
    total

def part2() : Int =
    var sum = 0
    var total = 0

    for line <- io.Source.fromFile("input.txt").getLines() do
        if(line == "")
            total += (sum == 7).toInt()
            sum = 0
        else
            for field <- line.split(" ") do
                field.slice(0, 3) match
                    case "byr" => sum += validate_byr(field).toInt()
                    case "iyr" => sum += validate_eyr(field).toInt()
                    case "eyr" => sum += validate_eyr(field).toInt() 
                    case "hgt" => sum += validate_hgt(field).toInt()
                    case "hcl" => sum += validate_hcl(field).toInt()
                    case "ecl" => sum += validate_ecl(field).toInt()
                    case "pid" => sum += validate_pid(field).toInt()
                    case _ => 0
                    
/*
    byr (Birth Year) - four digits; at least 1920 and at most 2002.
    iyr (Issue Year) - four digits; at least 2010 and at most 2020.
    eyr (Expiration Year) - four digits; at least 2020 and at most 2030.
    hgt (Height) - a number followed by either cm or in:
        If cm, the number must be at least 150 and at most 193.
        If in, the number must be at least 59 and at most 76.
    hcl (Hair Color) - a # followed by exactly six characters 0-9 or a-f.
    ecl (Eye Color) - exactly one of: amb blu brn gry grn hzl oth.
    pid (Passport ID) - a nine-digit number, including leading zeroes.
    cid (Country ID) - ignored, missing or not.
*/
                
    total

extension (b : Boolean)
    def toInt() = if (b) then 1 else 0
extension (num : Int)
    def in_range(min : Int, max : Int) = (min <= num) && (num <= max)

def validate_byr(str : String) : Boolean = str.drop(4).toInt.in_range(1920, 2002)
def validate_iyr(str : String) : Boolean = str.drop(4).toInt.in_range(2010, 2002)
def validate_eyr(str : String) : Boolean = 
    val value = str.drop(4)
    if(value.length != 4) then false else value.toInt.in_range(2020, 2030)
def validate_hgt(str : String) : Boolean =
    val unit = str.takeRight(2)
    val number = str.drop(4).dropRight(2)
    unit match
        case "cm" => number.toInt.in_range(150, 193)
        case "in" => number.toInt.in_range(59, 76)
        case _ => false

def validate_hcl(str : String) : Boolean = 
    if(str(4) != '#') then return false
    val number = str.drop(5)
    if(number.length() != 6) then return false
    boundary:
        for digit <- number do
            if !("1234567890abcdefABCDEF".toCharArray.contains(digit)) then break(false)
    true
def validate_ecl(str : String) : Boolean =
    str.drop(4) match
        case "amb" | "blu" | "brn" | "gry" | "grn" | "hzl" | "oth" => true
        case _ => false
    
def validate_pid(str : String) : Boolean = str.drop(4).length == 9
