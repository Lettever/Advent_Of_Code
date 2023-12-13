import std;
import std.datetime.stopwatch;

void main()
{
    writeln("part1 ", solve(1));
    writeln("part2 ", solve(2));
    auto dur = benchmark!(part1, part2)(1);
    dur.each!(x => writeln(x));
}
auto part1() => solve(1);
auto part2() => solve(2);
auto solve(int part)
{
    int total;
    foreach(e; lines("file.txt").split(""))
    {
        foreach(axis; 1 .. e[0].length)
            if(e.diff(axis).sum == part - 1)
            {
                total += axis;
                break;
            }
        e = rotate(e);
        foreach(axis; 1 .. e[0].length)
            if(e.diff(axis).sum == part - 1)
            {
                total += 100 * axis;
                break;
            }
        }
    return total;
}
char[][] rotate(char[][] matrix)
{
    char[][] result;
    for(int j = matrix[0].length - 1U; j >= 0; j--)
    {
        char[] temp;
        for(int i = 0; i < matrix.length; i++)
            temp ~= matrix[i][j];
        result ~= temp;
    }
    return result;
}
int[] diff(char[][] matrix, int axis)
{
    auto a = matrix.map!(x => x.map!(y => y == '#' ? 1 : 0).array);
    auto d = a.map!(x => zip(x[0 .. axis].dup.reverse, x[axis .. $]));
    int[] f;
    foreach(t; d)
    {
        int q;
        foreach(y; t)
            q += y[0] - y[1];
        f ~= abs(q);
    }
    return f;
}
bool is_valid(int[] arr)
{
    bool flag;
    foreach(c; arr)
        if(c > 1)
            return false;
        else if(c == 1)
            if(flag)
                return false;
            else
                flag = true;
    return flag;
}
auto lines(string file)
{
    File handle = File(file, "r");
    scope(exit)
        handle.close;
    return handle.byLine.map!(x => x.to!string.dup).array;
}