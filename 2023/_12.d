import std;

void main()
{
    writeln("part1 ", solve(1));
    writeln("part2 ", solve(2));
}
long solve(int part)
{
    auto parsed = lines("file.txt").map!(x => parse(x));
    return reduce!((a, b) => a + calculate(b[0], b[1], part))(0L, parsed);
}
long calculate(string str, int[] arr, int part)
{
    if(part == 2)
    {
        str = str.repeat(5).join('?');
        arr = arr.repeat(5).join;
    }
    str ~= '.';
    auto n = str.length;
    auto k = arr.length;
    arr ~= n + 1;

    auto f = new long [][][](n + 1, k + 2, n + 2);
    f[0][0][0] = 1;
    foreach (i; 0 .. n)
        foreach (j; 0 .. k + 1)
            foreach (p; 0 .. n + 1)
            {
                auto cur = f[i][j][p];
                if (!cur)
                    continue;
                if (str[i] == '.' || str[i] == '?')
                    if (p == 0 || p == arr[j - 1])
                        f[i + 1][j][0] += cur;
                if (str[i] == '#' || str[i] == '?')
                    f[i + 1][j + !p][p + 1] += cur;
            }
    return f[n][k][0];
}
Tuple!(string, int[]) parse(string str)
{
    auto a = str.split(" ");
    return tuple(a[0], a[1].split(",").to!(int[]));
}
auto lines(string file)
{
    File handle = File(file, "r");
    scope(exit)
        handle.close;
    return handle.byLine.map!(x => x.to!string).array;
}