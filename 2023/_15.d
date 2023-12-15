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
    auto arr = new Lens[][](256);
    foreach(elem; lines("file.txt")[0].split(","))
    {
        if(elem[$ - 1] == '-')
        {
            auto name = elem[0 .. $ - 1];
            auto h = hash(name);
            foreach(i; 0 .. arr[h].length)
                if(arr[h][i].name == name)
                {
                    arr[h] = arr[h].remove(i);
                    break;
                }
        }
        else
        {
            auto a = elem.split("=");
            int i = arr[hash(a[0])].countUntil!(x => x.name == a[0]);
            if(i == -1)
                arr[hash(a[0])] ~= Lens(a[0], a[1].to!int);
            else
                arr[hash(a[0])][i].length = a[1].to!int;
        }
    }
    long total;
    for(int i = 0; i < arr.length; i++)
        for(int j = 0; j < arr[i].length; j++)
            total += (i + 1) * (j + 1) * arr[i][j].length;
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