import std;

auto UP = [-1, 0], DOWN = [1, 0], LEFT = [0, -1], RIGHT = [0, 1];

void main()
{
    writeln("part1 ", part1);
    writeln("part2 ", part2);
}
auto part1()
{
    auto trees = lines("input.txt").map!(x => x.to!(char[]).map!(y => y - '0').array).array;
	int total;
	foreach(i; 0 .. trees.length)
		foreach(j; 0 .. trees[i].length)
			foreach(dir; [UP, DOWN, LEFT, RIGHT])
				if(trees.is_visible(i, j, dir))
				{
					total++;
					break;
				}
	return total;
}
auto part2()
{
    auto trees = lines("input.txt").map!(x => x.to!(char[]).map!(y => y - '0').array).array;
	int total;
	foreach(i; 0 .. trees.length)
		foreach(j; 0 .. trees[0].length)
			total = max(total, trees.calc(i, j));
    return total;
}
bool is_visible(uint[][] trees, int i, int j, int[] dir)
{
	auto tree = trees[i][j];
	i += dir[0];
	j += dir[1];
	while(0 <= i && i < trees.length && 0 <= j && j < trees[0].length)
	{
		if(trees[i][j] >= tree)
			return false;
		i += dir[0];
		j += dir[1];			
	}
	return true;
}
int calc(uint[][] trees, int i, int j)
{
	int total = 1;
	int t;
	for(t = i - 1; t >= 0; t--)
		if(trees[t][j] >= trees[i][j])
			break;
	total *= i - t;
	for(t = i + 1; t < trees.length; t++)
		if(trees[t][j] >= trees[i][j])
			break;
	total *= t - i - 1;
	for(t = j - 1; t >= 0; t--)
		if(trees[i][t] >= trees[i][j])
			break;
	total *= j - t - 1;
	for(t = j + 1; t < trees[0].length; t++)
		if(trees[i][t] >= trees[i][j])
			break;
	total *= t - j - 1;
	return total;
}
auto lines(string file)
{
    File handle = File(file, "r");
    scope(exit)
        handle.close;
    return handle.byLine.map!(x => x.to!string).array;
}