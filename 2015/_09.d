import std;

void main()
{
    writeln("part1 ", solve(1) == 207);
    writeln("part2 ", solve(2) == 804);
}
auto solve(int part)
{
	auto func = part == 1 ? &min!(int, int) : &max!(int, int);
	auto res = part == 1 ? int.max : 0;
	int[string][string] dist_map;
	foreach(line; lines("file.txt"))
	{
		auto q = line.split(" ");
		dist_map[q[0]][q[2]] = q[4].to!int;
		dist_map[q[2]][q[0]] = q[4].to!int;
	}
	return dist_map.keys().permutations().fold!((acc, x) => func(acc, calc(x.array, dist_map)))(res);
}
auto calc(string[] keys, int[string][string] dist_map)
{
	return keys.slide(2).fold!((acc, x) => acc + dist_map[x[0]][x[1]])(0);
}
auto lines(string file)
{
    File handle = File(file, "r");
    scope(exit)
        handle.close;
    return handle.byLine.map!(x => x.to!string).array;
}
/*
auto floyd_warshall(int[string][string] distance_map)
{
	auto indexes = zip(distance_map.byKey, iota(distance_map.length)).assocArray();
	int[][] dist = new int[][](distance_map.length, distance_map.length);
	foreach(line; dist)
		foreach(ref elem; line)
			elem = int.max / 10;
	foreach(k1, v; distance_map)
		foreach(k2, v2; v) {
			int i1 = indexes[k1];
			int i2 = indexes[k2];
			dist[i1][i2] = v2;
			dist[i2][i1] = v2;
			// writeln(indexes[k1], " ", indexes[k2]);
		}
	iota(distance_map.length).each!(x => dist[x][x] = 0);
	dist.each!writeln();
	readln;

	for(int k = 0; k < distance_map.length; k++)
		for(int i = 0; i < distance_map.length; i++)
			for(int j = 0; j < distance_map.length; j++)
				if(dist[i][j] > dist[i][k] + dist[k][j])
					dist[i][j] = dist[i][k] + dist[k][j];
	dist.each!writeln;
	auto a = dist.map!sum;
	writeln(a);
	writeln(a.minElement);
	return 1;
}
*/