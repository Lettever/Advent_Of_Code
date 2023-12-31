import std;

void main()
{
    writeln("part1 ", solve(1));
    writeln("part2 ", solve(2));
}

auto solve(int part)
{
    return lines("file.txt").map!(x => x.split(" ").to!(int[]).next_number(part)).sum;
}
long next_number(int[] arr, int part)
{
	if(part == 2)
		arr = arr.reverse;
	for(int i = arr.length - 1; i >= 1; i--)
		for(int j = 0; j < i; j++)
			arr[j] = arr[j + 1] - arr[j];
	return arr.sum;
}
auto lines(string file)
{
    File handle = File(file, "r");
    scope(exit)
        handle.close;
    return handle.byLine.map!(x => x.to!string).array;
}
