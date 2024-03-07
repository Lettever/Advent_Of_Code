import std;

void main()
{
    writeln("part1 ", part1() == 1025636);
    writeln("part2 ", part2() == 793873);
}
auto part1()
{
    auto elem_arr = lines("input.txt").rotate().map!elements.array();
    auto rates = elem_arr.fold!((acc, x) => tuple(acc[0] ~ x[0].key, acc[1] ~ x[1].key))(tuple("", ""));
    return rates[0].to!int(2) * rates[1].to!int(2);
}
auto part2()
{
    auto input = lines("input.txt");
    return input.get_rate(0).to!int(2) * input.get_rate(1).to!int(2);
}
string vertical_slice(string[] map, int j) => iota(map.length).map!(x => map[x][j]).array();
string[] rotate(string[] mat) => iota(mat[0].length).map!(x => mat.vertical_slice(x)).array();
auto elements(string str)
{
    int[char] m;
    foreach(ch; str)
        m[ch]++;
    return m.byPair().array().sort!((a, b) => a[1] < b[1]).array();
}
string get_rate(string[] input, int n)
{
    return iota(12).fold!((acc, x)
    {
        if(input.length == 1)
            return input[0];
        auto elem = input.vertical_slice(x).elements();
        acc ~= elem[0].value == elem[1].value ? '0' + n : elem[n].key;
        input = input.filter!(y => y.startsWith(acc)).array();
        return acc;
    })("");
}
auto lines(string file)
{
    File handle = File(file, "r");
    scope(exit)
        handle.close;
    return handle.byLine.map!(x => x.to!string).array;
}