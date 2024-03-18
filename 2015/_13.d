import std;

void main()
{
    writeln("part1 ", solve(1));
    writeln("part2 ", solve(2));
}
auto solve(int part)
{
    auto input = lines("input.txt");
    int[string][string] happ_map;
    auto r = r"^(\w+) would (\w+) (\d+) happiness units by sitting next to (\w+).$";
    foreach(a; input) {
        auto info = (e =>
            tuple(e[0], e[3], e[2].to!int * (e[1] == "gain" ? 1 : - 1))
        )(matchFirst(a, r).drop(1).array());
        happ_map[info[0]][info[1]] = info[2];
    }
    if(part == 2)
    {
        auto ky = keys(happ_map);
        foreach(k; ky)
        {
            happ_map[k]["me"] = 0;
            happ_map["me"][k] = 0;
        }
    }
    return happ_map.keys().permutations().fold!((acc, x) => max(acc, calc(x.array, happ_map)))(0);

}
auto calc(string[] keys, int[string][string] happ_map){
    return happ_map[keys[$ - 1]][keys[0]] + happ_map[keys[0]][keys[$ - 1]] +
    keys.slide(2).fold!((acc, x) => acc + happ_map[x[0]][x[1]] + happ_map[x[1]][x[0]])(0);
}
auto lines(string file)
{
    File handle = File(file, "r");
    scope(exit)
        handle.close;
    return handle.byLineCopy.array();
}