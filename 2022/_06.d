import std;

void main()
{
    writeln("part1 ", solve(1));
    writeln("part2 ", solve(2));
}

auto solve(int part) => marker(lines("input.txt")[0], part);
int marker(string str, int part)
{
	auto length = part == 1 ? 4 : 14;
	for(int i = 0; i < str.length - length; i++)
		if(!duplicate(str[i .. i + length]))
			return i + length;
	assert(0);
}
bool duplicate(string str)
{
	for(int i = 0; i < str.length; i++)
		for(int j = i + 1; j < str.length; j++)
			if(str[i] == str[j])
				return true;
	return false;
}
auto lines(string file)
{
    File handle = File(file, "r");
    scope(exit)
        handle.close;
    return handle.byLine.map!(x => x.to!string).array;
}