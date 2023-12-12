import std;

void main()
{
    writeln("part1 ", solve(1));
    writeln("part2 ", solve(2));
}
int solve(int part)
{
    auto count_func = part == 1 ? &count : &count2;
    int total = lines("file.txt").map!(x => x.length - count_func(x)).sum;
    if(part == 1)
        return total;
    return -total;
}
int count(string str)
{
    int total = str.length;
    for(int i = 0; i < str.length; i++)
        if(str[i] == '\"')
            total--;
        else if(str[i] == '\\')
            if(str[i + 1] != 'x')
            {
                total--;
                i++;
            }
            else
            {
                total -= 3;
                i += 3;
            }
    return total;
}
int count2(string str)
{
    int total = str.length + 2;
    foreach(c; str)
        if(c == '\\' || c == '\"')
            total++;
    return total;
}
auto lines(string file)
{
    File handle = File(file, "r");
    scope(exit)
        handle.close;
    return handle.byLine.map!(x => x.to!string).array;
}