import std;
struct Point
{
    int diagonal, row, col;
    void opUnary(string op : "++")()
    {
        row--;
        col++;
        if(row < 0)
        {
            diagonal++;
            col = 0;
            row = diagonal;
        }
    }
}
void main()
{
    writeln("part1 ", part1);
    writeln("part2 ", part2);
}
long part1()
{
    File input = File("file.txt", "r");
    auto end_point = Point();
    auto point = Point();
    input.readln.chomp.formattedRead(
        "To continue, please consult the code grid in the manual.  Enter the code at row %d, column %d.",
        end_point.row, end_point.col);
    input.close;

    end_point.row--;
    end_point.col--;

    long num1 = 20_151_125;
    while(!cmp(end_point, point++))
        num1 = num1.next;

    return num1;
}
int part2()
{
    File input = File("file.txt", "r");
    input.close;
    return 0;
}
long next(long num)
{
    return (num * 252_533) % 33_554_393;
}
bool cmp(Point p1, Point p2)
{
    return (p1.col == p2.col) && (p1.row == p2.row);
}