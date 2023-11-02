import std.stdio;
import std.string;
import std.format;
import std.algorithm;
struct Count
{
    int value, freq = 1;
    this(int a)
    {
        value = a;
    }
}
void main()
{
    writeln("part1 ", solve(40));
    writeln("part2 ", solve(50));
}
int solve(int steps)
{
    File input = File("file.txt", "r");
    string number = input.readln.chomp;
    foreach(_ ; 0 .. steps)
        number = number.next.toString;
    input.close;
    return number.length;
}
Count[] next(string number)
{
    Count []array;
    array ~= Count(number[0] - '0');
    for(int i = 1; i < number.length; i++)
        if(number[i] - '0' == array[$ - 1].value)
            array[$ - 1].freq++;
        else
            array ~= Count(number[i] - '0');
    return array;
}
string toString(Count []array)
{
    string str = "";
    foreach(key; array)
    {
        str ~= key.freq + '0';
        str ~= key.value + '0';
    }
    return str;
}