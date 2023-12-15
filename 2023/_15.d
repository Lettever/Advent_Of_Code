import std;
struct Lens
{
    string name;
    int length;
    this(string n, int l)
    {
        name = n;
        length = l;
    }
}
void main()
{
    writeln("part1 ", part1);
    writeln("part2 ", part2);
}
auto part1()
{
    return lines("file.txt")[0].split(",").map!hash.sum;
}
auto part2()
{
    auto boxes = new Lens[][](256);
    foreach(elem; lines("file.txt")[0].split(","))
    {
        if(elem[$ - 1] == '-')
        {
            auto name = elem[0 .. $ - 1];
            auto h = hash(name);
            foreach(i, lens; boxes[h])
                if(lens.name == name)
                {
                    boxes[h] = boxes[h].remove(i);
                    break; 
                }
        }
        else
        {
            auto a = elem.split("=");
            int i = boxes[hash(a[0])].countUntil!(x => x.name == a[0]);
            if(i == -1)
                boxes[hash(a[0])] ~= Lens(a[0], a[1].to!int);
            else
                boxes[hash(a[0])][i].length = a[1].to!int;
        }
    }
    long total;
    foreach(i, box; boxes)
        foreach(j, lens; box)
            total += (i + 1) * (j + 1) * lens.length;
    return total;
}
int hash(string str)
{
    return reduce!((a, b) => (a + b) * 17 % 256)(0, str);
}
auto lines(string file)
{
    File handle = File(file, "r");
    scope(exit)
        handle.close;
    return handle.byLine.map!(x => x.to!string).array;
}
