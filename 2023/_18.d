import std;

struct Point
{
    int x, y;
    this(int x, int y)
    {
        this.x = x;
        this.y = y;
    }
    auto opBinary(string op : "+")(const Point rhs) const
    {
        return Point(x + rhs.x, y + rhs.y); 
    }
    auto opBinary(string op : "*")(const int scalar) const
    {
        return Point(x * scalar, y * scalar); 
    }
    void opOpAssign(string op : "+")(Point rhs)
    {
        this = this + rhs;
    }
    void opOpAssign(string op : "*")(int scalar)
    {
        this = this * scalar;
    }
}

void main()
{
    writeln("part1 ", part1);
    writeln("part2 ", part2);
}
auto part1()
{
    auto input = lines("test.txt");
    long total; 
    auto vertices = [Point(0, 0)];
    foreach(line; input)
    {
        auto h = line.split(" ");
        auto n = vertices[$ - 1];
        total += h[1].to!int;
        if(h[0] == "U")
            vertices ~= n + Point(0, -1) * (h[1].to!int);
        else if(h[0] == "D")
            vertices ~= n + Point(0, 1) * (h[1].to!int);
        else if(h[0] == "R")
            vertices ~= n + Point(1, 0) * (h[1].to!int);
        else if(h[0] == "L")
            vertices ~= n + Point(-1, 0) * (h[1].to!int);
        else
            writeln("idk");
    }
    writeln(total);
    writeln(vertices);
    writeln(sholace_theorem(vertices));
    return sholace_theorem(vertices) - total / 2 + 1;
    //i = 38
    //A = 42
    //62
    //A = i + b /2  - 1
    //i = A - b / 2 + 1
    //A + i = ?
    //2 * A - b / 2 + 1
}
//129108 is too high
auto part2()
{
    return 0;
}
long sholace_theorem(Point[] vertices)
{
	long sum = vertices[$ - 1].x * vertices[0].y - vertices[0].x * vertices[$ - 1].y;
	for(int i = 0; i < vertices.length - 1U; i++)
		sum += vertices[i].x * vertices[i + 1].y - vertices[i + 1].x * vertices[i].y;
	return sum / 2;
}
auto lines(string file)
{
    File handle = File(file, "r");
    scope(exit)
        handle.close;
    return handle.byLine.map!(x => x.to!string).array;
}