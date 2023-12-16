import std;

void main()
{
    writeln("part1 ", part1);
    writeln("part2 ", part2);
}

auto part1()
{
    return lines("input.txt").fold!((a, b) {
		int[2] elf1, elf2;
		b.formattedRead("%d-%d,%d-%d", elf1[0], elf1[1], elf2[0], elf2[1]);
		return a + (elf1[0] >= elf2[0] && elf1[1] <= elf2[1] || elf2[0] >= elf1[0] && elf2[1] <= elf1[1]);
	})(0);
}
auto part2()
{
	return lines("input.txt").fold!((a, b) {
		int[2] elf1, elf2;
		b.formattedRead("%d-%d,%d-%d", elf1[0], elf1[1], elf2[0], elf2[1]);
		return a + (elf1[0] <= elf2[1] && elf1[1] >= elf2[0]);
	})(0);
}
auto lines(string file)
{
    File handle = File(file, "r");
    scope(exit)
        handle.close;
    return handle.byLine.map!(x => x.to!string).array;
}