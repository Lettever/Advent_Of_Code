import std;

class Map
{
	string name;
	this(string n)
	{
		name = n;
	}
	Map left = null, right = null;
}
void main()
{
    writeln("part1 ", part1);
    writeln("part2 ", part2);
}

auto part1()
{
    auto maps = lines("file.txt").map!(x => x
		.replace(" = (", " ")
		.replace(", ", " ")
		.replace(")", "")
		.split(" ")).array;
	auto directions = maps[0][0];
	Map[string] name_to_map;
	maps = maps[2 .. $];
	foreach(map; maps)
	{
		for(int i = 0; i < map.length; i++)
			if(map[i] !in name_to_map)
				name_to_map[map[i]] = new Map(map[i]);
		name_to_map[map[0]].left = name_to_map[map[1]];
		name_to_map[map[0]].right = name_to_map[map[2]];
	}
	auto cursor = name_to_map["AAA"];
	int i, steps;
	while(cursor.name != "ZZZ")
	{
		if(directions[i] == 'L')
			cursor = cursor.left;
		else
			cursor = cursor.right;
		i++;
		if(i == directions.length)
			i = 0;
		steps++;
	}

    return steps;
}
auto part2()
{
    auto maps = lines("file.txt").map!(x => x
		.replace(" = (", " ")
		.replace(", ", " ")
		.replace(")", "")
		.split(" ")).array;
	auto directions = maps[0][0];
	Map[string] name_to_map;
	maps = maps[2 .. $];
	foreach(map; maps)
	{
		for(int i = 0; i < map.length; i++)
			if(map[i] !in name_to_map)
				name_to_map[map[i]] = new Map(map[i]);
		name_to_map[map[0]].left = name_to_map[map[1]];
		name_to_map[map[0]].right = name_to_map[map[2]];
	}
	int[] steps_array;
	foreach(k, v; name_to_map)
		if(k[$ - 1] == 'A')
			steps_array ~= steps(v, directions);
	return lcm(steps_array);
}
int steps(Map cursor, string directions)
{
	int i, steps;
	while(cursor.name[$ - 1] != 'Z')
	{
		if(directions[i] == 'L')
			cursor = cursor.left;
		else
			cursor = cursor.right;
		steps++;
		i++;
		if(i == directions.length)
			i = 0;
	}
	return steps;
}
long lcm(int[] arr)
{
	long ans = arr[0];
	for(int i = 1; i < arr.length; i++)
		ans = (arr[i] * ans) / gcd(arr[i], ans);
	return ans;
}
long gcd(long a, long b)
{
    if (b == 0)
        return a;
    return gcd(b, a % b);
}
auto lines(string file)
{
    File handle = File(file, "r");
    scope(exit)
        handle.close;
    return handle.byLine.map!(x => x.to!string).array;
}