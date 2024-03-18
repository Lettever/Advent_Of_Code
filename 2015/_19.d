import ascii = std.ascii;
import algo = std.algorithm.searching : count;
import std;

void main()
{
    writeln("part1 ", part1);
    writeln("part2 ", part2);
}
auto part1()
{
    auto input = lines("input.txt").split("");
    string[][string] rules;
    foreach(rule; input[0].map!(x => x.split(" => ")))
        rules[rule[0]] ~= rule[1];
    string str = input[1][0];
    bool[string] arr;
    foreach(k, v; rules)
        foreach(i; indexes(str, k))
            foreach(v2; v)
                arr[str[0 .. i] ~ v2 ~ str[i + k.length .. $]] = true ;
    return arr.length;
}
auto part2()
{
    auto s1 = lines("input.txt").split("")[1][0];
    auto s2 = s1
        .replace("Rn", "(")
        .replace("Y", ",")
        .replace("Ar", ")");
    auto vals = zip("(),", [1, 1, 2]).map!(x => tuple(x[0], x[1])).assocArray();
    return algo.count!(x => ascii.isUpper(x))(s1) - s2.fold!((acc, x) => acc + vals.get(x, 0))(0) - 1;
}
int[] indexes(string str, string needle)
{
    int[] res;
    for(int i = 0; i < str.length - needle.length + 1; i++)
        if(str[i .. i + needle.length] == needle)
            res ~= i;
    return res;
}
auto lines(string file)
{
    File handle = File(file, "r");
    scope(exit)
        handle.close;
    return handle.byLine.map!(x => x.to!string).array;
}
