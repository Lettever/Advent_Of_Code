import std;

void main()
{
    writeln("part1 ", part1);
    writeln("part2 ", part2);
}

auto part1()
{
    auto lines = lines("input.txt").split("")[1];
	string[] stacks;
	stacks ~= "WDGBHRV";
	stacks ~= "JNGCRF";
	stacks ~= "LSFHDNJ";
	stacks ~= "JDSV";
	stacks ~= "SHDRQWNV";
	stacks ~= "PGHCM";
	stacks ~= "FJBGLZHC";
	stacks ~= "SJR";
	stacks ~= "LGSRBNVM";
	foreach(line; lines)
	{
		int crates, og_stack, next_stack;
		line.formattedRead("move %d from %d to %d", crates, og_stack, next_stack);
		og_stack--;
		next_stack--;
		foreach(_; 0 .. crates)
		{
			stacks[next_stack] ~= stacks[og_stack][$ - 1];
			stacks[og_stack] = stacks[og_stack][0 .. $ - 1];
		}
	}
	return stacks.map!(x => x[$ - 1]);
}
auto part2()
{
    auto lines = lines("input.txt").split("")[1];
	string[] stacks;
	stacks ~= "WDGBHRV";
	stacks ~= "JNGCRF";
	stacks ~= "LSFHDNJ";
	stacks ~= "JDSV";
	stacks ~= "SHDRQWNV";
	stacks ~= "PGHCM";
	stacks ~= "FJBGLZHC";
	stacks ~= "SJR";
	stacks ~= "LGSRBNVM";
	foreach(line; lines)
	{
		int crates, og_stack, next_stack;
		line.formattedRead("move %d from %d to %d", crates, og_stack, next_stack);
		og_stack--;
		next_stack--;
		stacks[next_stack] ~= stacks[og_stack][$ - crates .. $];
		stacks[og_stack] = stacks[og_stack][0 .. $ - crates];
	}
	return stacks.map!(x => x[$ - 1]);
}
auto lines(string file)
{
    File handle = File(file, "r");
    scope(exit)
        handle.close;
    return handle.byLine.map!(x => x.to!string).array;
}