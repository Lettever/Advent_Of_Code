import std;

void main()
{
    writeln("part1 ", solve(1));
    writeln("part2 ", solve(2));
}
auto solve(int part)
{
    auto a = [
        "children": 3,
        "cats": 7,
        "samoyeds": 2,
        "pomeranians": 3,
        "akitas": 0,
        "vizslas": 0,
        "goldfish": 5,
        "trees": 3,
        "cars": 2,
        "perfumes": 1
    ];
    auto input = lines("input.txt");
    int[string][] info;
    foreach(line; input)
    {
        auto real_info = line.findSplitAfter(": ")[1].split(", ");
        int[string] temp;
        foreach(w; real_info.map!(x => x.split(": ")))
            temp[w[0]] = w[1].to!int;
        info ~= temp;
    }
    auto sues = iota(0, 500).array();
    while(sues.length > 1)
    {
        sues = sues.filter!((x1) {
            auto x = info[x1];
            foreach(k; a.keys())
            {
                if(k !in x)
                    continue;
                if(part == 2 && canFind(["cats", "trees", "pomeranians", "goldfish"], k))
                {
                    if(k == "cats" || k == "trees")
                        if(x[k] <= a[k])
                            return false;
                    if(k == "pomeranians" || k == "goldfish")
                        if(x[k] >= a[k])
                            return false;
                }
                else if(x[k] != a[k])
                    return false;
            }
            return true;
        }).array();
    }
    return sues[0] + 1;
}
auto lines(string file)
{
    File handle = File(file, "r");
    scope(exit)
        handle.close;
    return handle.byLine.map!(x => x.to!string).array;
}