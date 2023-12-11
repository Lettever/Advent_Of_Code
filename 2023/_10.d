import std;

auto UP = [-1, 0], DOWN = [1, 0], LEFT = [0, -1], RIGHT = [0, 1];

void main()
{
	writeln("part1 ", part1);
	writeln("part2 ", part2);
}
auto part1()
{
	auto lines = lines("file.txt");
	int i, j;
	outer:
	for(i = 0; i < lines.length; i++)
		for(j = 0; j < lines[i].length; j++)
			if(lines[i][j] == 'S')
				break outer;
	int[] dir = RIGHT;
	int length;
	do
	{
		add(i, j, dir);
		length++;
		change_direction(dir, lines[i][j]);
	}while(lines[i][j] != 'S');
	return length / 2;
}
auto part2()
{
    auto lines = lines("file.txt").to!(char[][]);
	int i, j;
	outer:
	for(i = 0; i < lines.length; i++)
		for(j = 0; j < lines[i].length; j++)
			if(lines[i][j] == 'S')
				break outer;
	lines[i][j] = 'L';
	int[] dir = RIGHT;
	int[][] vertices;
	vertices ~= [i, j];
	int length;
	do
	{
		add(i, j, dir);
		change_direction(dir, lines[i][j]);
		length++;
		if("7LFJ".canFind(lines[i][j]))
			vertices ~= [i, j];
	}while((i != vertices[0][0]) || (j != vertices[0][1]));
	return sholace_theorem(vertices) - length / 2 + 1; //picks theorem
}

void change_direction(ref int[] dir, char pipe)
{
	if(pipe == '|' || pipe == '-' || pipe == 'S')
		return;
	if(pipe == 'L')
		if(dir == DOWN)
			dir = RIGHT;
		else
			dir = UP;
	else if(pipe == 'J')
		if(dir == DOWN)
			dir = LEFT;
		else
			dir = UP;
	else if(pipe == '7')
		if(dir == RIGHT)
			dir = DOWN;
		else
			dir = LEFT;
	else if(pipe == 'F')
		if(dir == UP)
			dir = RIGHT;
		else
			dir = DOWN;
	else
		assert(0);
}
void add(ref int i, ref int j, int[] dir)
{
	i += dir[0];
	j += dir[1];
}
long sholace_theorem(int[][] vertices)
{
	auto l_vertices = vertices.to!(long[][]);
	long sum;
	for(int i = 0; i < l_vertices.length - 1; i++)
		sum += (l_vertices[i][0] * l_vertices[i + 1][1] - l_vertices[i + 1][0]*l_vertices[i][1]);
	sum += (l_vertices[$ - 1][0] * l_vertices[0][1] - l_vertices[0][0]*l_vertices[$ - 1][1]);
	return sum / 2;
}
auto lines(string file)
{
    File handle = File(file, "r");
    scope(exit)
        handle.close;
    return handle.byLine.map!(x => x.to!(string)).array;
}
