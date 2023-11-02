import std;
import std.digest.md;

void main()
{
    writeln("part1 ", part1);
    writeln("part2 ", part2);
}
int part1()
{
    File input = File("file.txt", "r");
    string str = input.readln.chomp;
    int num;
    while(!is_valid(str, num, 5))
        num++;
    return num;
}
int part2()
{
    File input = File("file.txt", "r");
    string str = input.readln.chomp;
    int num;
    while(!is_valid(str, num, 6))
        num++;
    return num;
}
bool is_valid(string str, int num, int zeros)
{
    return md5Of(str ~ num.to!string).toHexString[0 .. zeros] == replicate("0", zeros);
}