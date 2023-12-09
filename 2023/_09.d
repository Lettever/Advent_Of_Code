import std;

void main()
{
    writeln("part1 ", solve(1));
    writeln("part2 ", solve(2));
}

auto solve(int part)
{
    return lines("file.txt").map!(x => x.split(" ").to!(int[])).array
        .map!(x => next_number(x, part)).sum;
}
long next_number(int[] arr, int part)
{
    if(part == 2)
		arr = arr.reverse;
    auto arrs = [arr];
    while(!all_zeros(arrs[$ - 1]))
    {
        auto curr_arr = arrs[$ - 1];
        int[] temp;
        for(int i = 1; i < curr_arr.length; i++)
            temp ~= curr_arr[i] - curr_arr[i - 1];
        arrs ~= temp;
    }
	return arrs.map!(x => x[$ - 1]).sum;
}
bool all_zeros(int[] arr)
{
    foreach(n; arr)
        if(n != 0)
            return false;
    return true;
}
auto lines(string file)
{
    File handle = File(file, "r");
    scope(exit)
        handle.close;
    return handle.byLine.map!(x => x.to!string).array;
}
