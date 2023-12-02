import std;

void main()
{
    writeln("part1 ", part1);
    writeln("part2 ", part2);
}

int part1()
{
    auto lines = lines("file.txt");
	int total;
	foreach(line; lines)
	{
		int[string] limit = ["red" : 12, "green" : 13, "blue" : 14];
		auto splitted = line.findSplit(": ").array;
		int game_id = splitted[0][5 .. $].to!int;
		string bags = splitted[2];
		foreach(set; bags.split("; "))
		{
			foreach(die; set.split(", "))
			{
				auto e = die.split(" ");
				if(e[0].to!int > limit[e[1]])
					goto here;
			}
		}
		total += game_id;
		here:
	}
    return total;
}
int part2()
{
    auto lines = lines("file.txt");
	int total;
	foreach(line; lines)
	{
		int[string] max = ["red" : 0, "green" : 0, "blue" : 0];
		int[string] limit = ["red" : 12, "green" : 13, "blue" : 14];
		auto splitted = line.findSplit(": ").array;
		string bags = splitted[2];
		foreach(set; bags.split("; "))
		{
			foreach(die; set.split(", "))
			{
				auto e = die.split(" ");
				if(e[0].to!int > max[e[1]])
					max[e[1]] = e[0].to!int;
			}
		}
		total += max["red"] * max["green"] * max["blue"];
	}
    return total;
}
auto lines(string file)
{
    File handle = File(file, "r");
    scope(exit)
        handle.close;
    return handle.byLine.map!(x => x.to!string).array;
}