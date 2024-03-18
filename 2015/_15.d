import std;

void main()
{
    writeln("part1 ", solve(1) == 222870);
    writeln("part2 ", solve(2) == 117936);
}
auto solve(int part)
{
    auto r = r"\w+: \w+ (-?\d+), \w+ (-?\d+), \w+ (-?\d+), \w+ (-?\d+), \w+ (-?\d+)";
    auto arr = lines("input.txt").map!(x => matchFirst(x, r).drop(1).array().to!(int[])).array();
    arr = iota(arr[0].length)
        .map!(c => iota(arr.length).map!(r => arr[r][c]).array())
        .array();

    long res = 0;
    foreach(i; iota(101))
        foreach(j; iota(101))
            foreach(k; iota(101))
            {
                int l = 100 - i - j - k;
                auto q = [i, j, k, l];
                auto a2 = iota(5).map!((w) =>
                    iota(4).fold!((acc, x) => acc + arr[w][x] * q[x])(0L).max(0)
                );
                if(part == 2 && a2[$ - 1] != 500)
                    continue;
                res = res.max(iota(4).fold!((acc, x) => acc * a2[x])(1L));
            }
    return res;
}
auto lines(string file)
{
    File handle = File(file, "r");
    scope(exit)
        handle.close;
    return handle.byLine.map!(x => x.to!string).array;
}