import std;

void main()
{
    writeln("part1 ", solve(1));
    writeln("part2 ", solve(2));
}
auto solve(int part)
{
    long helper(JSONValue json)
    {
        if(json.type == JSONType.integer)
            return json.integer;
        else if(json.type == JSONType.object)
        {
            if(part == 2)
                foreach(string k, v; json)
                    if(v.type == JSONType.string && v.str == "red")
                        return 0; 
            long s;
            foreach(string k, v; json)
                s += helper(v);
            return s;
        }
        else if(json.type == JSONType.array)
        {
            long s;
            foreach(uint k, v; json)
                s += helper(v);
            return s;
        }
        else
            return 0;
    }
    return helper(lines("file.txt")[0].parseJSON());
}
auto lines(string file)
{
    File handle = File(file, "r");
    scope(exit)
        handle.close;
    return handle.byLine.map!(x => x.to!string).array;
}
