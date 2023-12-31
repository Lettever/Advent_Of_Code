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
    return solve(lines("file.txt").map!(x => x
		.replace("one", "o1e")
		.replace("two", "t2o")
		.replace("three", "t3e")
		.replace("four", "f4r")
		.replace("five", "f5e")
		.replace("six", "s6x")
		.replace("seven", "s7n")
		.replace("eight", "e8t")
		.replace("nine", "n9e")
	).array);
}
int solve(string[] strs)
{
	return strs.fold!((acc, x) => acc + func(x.filter!(y => digits.canFind(y)).to!string).to!int)(0);
}
string func(string str) => "" ~ str[0] ~ str[$ - 1];
auto lines(string file)
{
    File handle = File(file, "r");
    scope(exit)
        handle.close;
    return handle.byLine.map!(x => x.to!string).array;
}
