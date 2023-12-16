import std;

void main()
{
    writeln("part1 ", solve(1));
    writeln("part2 ", solve(2));
}
auto solve(int part)
{
	auto arr = part == 1 ? [[4, 8, 3], [1, 5, 9], [7, 2, 6]] : [[3, 4, 8], [1, 5, 9], [2, 6, 7]];
	return lines("input.txt").fold!((a, b) => a + arr[b[0] - 'A'][b[2] - 'X'])(0);
}
auto lines(string file)
{
    File handle = File(file, "r");
    scope(exit)
        handle.close;
    return handle.byLine.map!(x => x.to!string).array;
}