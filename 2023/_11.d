import std;

struct Point
{
	int i, j;
	this(int a, int b)
	{
		i = a;
		j = b;
	}
}
void main()
{
    writeln("part1 ", solve(1));
    writeln("part2 ", solve(2));
}

auto solve(int part)
{
    auto universe = lines("file.txt");
	auto cost = universe.map!(x => x.map!(y => 1).array).array;
	Point[] galaxies;
	for(int i = 0; i < universe.length; i++)
	{
		if(!universe.contain_galaxies_row(i))
			cost.add_row(i, part);
		for(int j = 0; j < universe.length; j++)
			if(universe[i][j] == '#')
				galaxies ~= Point(i, j);
	}
	for(int j = 0; j < universe[0].length; j++)
		if(!universe.contain_galaxies_columns(j))
			cost.add_column(j, part);
	long total;
	for(int i = 0; i < galaxies.length; i++)
		for(int j = i + 1; j < galaxies.length; j++)
			total += cost.distance(galaxies[i], galaxies[j]);
	return total;
}
int distance(int[][] cost, Point p1, Point p2)
{
	int total;
	int di = p2.i - p1.i;
	if(di != 0)
		di /= abs(di);
	int dj = p2.j - p1.j;
	if(dj != 0)
		dj /= abs(dj);
	while(p1.i != p2.i)
	{
		p1.i += di;
		total += cost[p1.i][p1.j];
	}
	while(p1.j != p2.j)
	{
		p1.j += dj;
		total += cost[p1.i][p1.j];
	}
	return total;
}
bool contain_galaxies_row(string[] universe, int row)
{
	foreach(a; universe[row])
		if(a == '#')
			return true;
	return false;
}
bool contain_galaxies_columns(string[] universe, int column)
{
	foreach(a; universe.map!(x => x[column]))
		if(a == '#')
			return true;
	return false;
}
void add_row(int[][] mat, int row, int part)
{
	int inc = part == 1 ? 1 : 1000000 - 1;
	for(int i = 0; i < mat.length; i++)
		mat[row][i] += inc;
}
void add_column(int[][] mat, int column, int part)
{
	int inc = part == 1 ? 1 : 1000000 - 1;
	for(int i = 0; i < mat[column].length; i++)
		mat[i][column] += inc;
}
auto lines(string file)
{
    File handle = File(file, "r");
    scope(exit)
        handle.close;
    return handle.byLine.map!(x => x.to!string).array;
}