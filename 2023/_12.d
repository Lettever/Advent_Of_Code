import std;

void main()
{
    writeln("part1 ", part1);
    writeln("part2 ", part2);
}
auto part1()
{
    long res = 0;
	foreach(line; lines("file.txt").map!(x => parse(x)))
    {
		auto s = line[0] ~ '.';
		auto a = line[1];
		auto n = s.length;
		auto k = a.length;
		a ~= n + 1;

		auto f = new long [][][](n + 1, k + 2, n + 2);
		f[0][0][0] = 1;
		foreach (i; 0 .. n)
			foreach (j; 0 .. k + 1)
				foreach (p; 0 .. n + 1)
                {
					auto cur = f[i][j][p];
					if (!cur)
						continue;
					if (s[i] == '.' || s[i] == '?')
						if (p == 0 || p == a[j - 1])
							f[i + 1][j][0] += cur;
					if (s[i] == '#' || s[i] == '?')
						f[i + 1][j + !p][p + 1] += cur;
				}
		res += f[n][k][0];
	}
    return res;
}
long part2()
{
    long res = 0;
	foreach(line; lines("file.txt").map!(x => parse(x)))
    {
		auto s = line[0].repeat(5).join('?') ~ '.';
		auto a = line[1].repeat(5).join;
		auto n = s.length;
		auto k = a.length;
		a ~= n + 1;

		auto f = new long [][][](n + 1, k + 2, n + 2);
		f[0][0][0] = 1;
		foreach (i; 0 .. n)
			foreach (j; 0 .. k + 1)
				foreach (p; 0 .. n + 1) {
					auto cur = f[i][j][p];
					if (!cur)
						continue;
					if (s[i] == '.' || s[i] == '?')
						if (p == 0 || p == a[j - 1])
							f[i + 1][j][0] += cur;
					if (s[i] == '#' || s[i] == '?')
						f[i + 1][j + !p][p + 1] += cur;
				}
		res += f[n][k][0];
	}
    return res;
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
/*
    ???.### 1,1,3 - 1 arrangement = C(2, 2)
    .??..??...?##. 1,1,3 - 4 arrangements = C(2, 1) + C(2, 1)
    ?#?#?#?#?#?#?#? 1,3,1,6 - 1 arrangement 
    ????.#...#... 4,1,1 - 1 arrangement = C(4, 4)
    ????.######..#####. 1,6,5 - 4 arrangements = C(4, 1)
    ?###???????? 3,2,1 - 10 arrangements = C(4, 2) + C(4, 1)
*/