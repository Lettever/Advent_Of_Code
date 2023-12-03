import std;

void main()
{
    writeln("part1 ", part1);
    writeln("part2 ", part2);
}

int part1()
{
	return solve(lines("file.txt"));
}
int part2()
{
    return lines("file.txt").map!(x => x
		.replace("one", "o1e")
		.replace("two", "t2o")
		.replace("three", "t3ree")
		.replace("four", "f4ur")
		.replace("five", "f5ve")
		.replace("six", "s6x")
		.replace("seven", "s7ven")
		.replace("eight", "e8ght")
		.replace("nine", "n9ne")
	).array.solve;
}
int solve(string[] strs)
{
	int sum;
	foreach(line; strs)
	{
		auto filtered = line.filter!(x => digits.canFind(x)).to!string;
		sum += ("" ~ filtered[0] ~ filtered[$ - 1]).to!int;
	}
    return sum;	
}
auto lines(string file)
{
    File handle = File(file, "r");
    scope(exit)
        handle.close;
    return handle.byLine.map!(x => x.to!string).array;
}
