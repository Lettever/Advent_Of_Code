import std;

void main()
{
    writeln("part1 ", part1);
    writeln("part2 ", part2);
}

auto part1()
{
	return lines("input.txt").fold!((a, b) => 
		a + common(b[0 .. $ / 2], b[$ / 2 .. $]).score
	)(0);
}
auto part2()
{
    return lines("input.txt").chunks(3).fold!((a, b) => a + common(b.to!(string[3]).tupleof).score)(0);
}
char common(string str1, string str2)
{
	foreach(ch1; str1)
		foreach(ch2; str2)
				if(ch1 == ch2)
					return ch1;
	assert(0);
}
char common(string str1, string str2, string str3)
{
	foreach(ch1; str1)
		foreach(ch2; str2)
			foreach(ch3; str3)
				if(ch1 == ch2 && ch1 == ch3)
					return ch1;
	assert(0);
}
int score(char ch)
{
	if('a' <= ch && ch <= 'z')
		return ch - 'a' + 1;
	return ch - 'A' + 27;
}
auto lines(string file)
{
    File handle = File(file, "r");
    scope(exit)
        handle.close;
    return handle.byLine.map!(x => x.to!string).array;
}