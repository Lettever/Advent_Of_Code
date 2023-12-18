import std;

struct Point
{
    long x, y;
    this(long x, long y)
    {
        this.x = x;
        this.y = y;
    }
    void opOpAssign(string op : "+")(Point rhs)
    {
        this.x += rhs.x;
		this.y += rhs.y;
    }
}

void main()
{
    writeln("part1 ", solve(1));
    writeln("part2 ", solve(2));
}
long solve(int part)
{
	auto str = part == 1 ? "UDRL" : "3102";
	long length;
	Point[] vertices;
	auto cursor = Point(0, 0);
	foreach(line; lines("input.txt"))
	{
		auto h = line.split(" ");
		auto num = part == 1 ? h[1].to!long : hex_to_long(h[2][2 .. $ - 2]);
		auto ch = part == 1 ? h[0][0] : h[2][$ - 2];
		length += num;
		auto arr = [Point(0, -num), Point(0, num), Point(num, 0), Point(-num, 0)];
		auto p = arr[str.indexOf(ch)];
		cursor += p;
		vertices ~= cursor;
	}
    return sholace_theorem(vertices) + length / 2 + 1;
}
long sholace_theorem(Point[] vertices)
{
	long sum = vertices[$ - 1].x * vertices[0].y - vertices[0].x * vertices[$ - 1].y;
	for(int i = 0; i < vertices.length - 1U; i++)
		sum += vertices[i].x * vertices[i + 1].y - vertices[i + 1].x * vertices[i].y;
	return sum / 2;
}
long hex_to_long(string hex)
{
	auto str = "0123456789abcdef";
	return hex.fold!((a, b) => a * 16 + str.indexOf(b))(0);
}
auto lines(string file)
{
    File handle = File(file, "r");
    scope(exit)
        handle.close;
    return handle.byLine.map!(x => x.to!string).array;
}
