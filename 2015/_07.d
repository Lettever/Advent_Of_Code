import std;

class Wire
{
    string name, op;
    int value;
    bool known;
    Wire left = null, right = null;
    this(string n)
    {
        name = n;
    }
    void set(int v)
    {
        value = v;
        known = true;
    }
    int get_value()
    {
        if(known)
            return value;
        known = true;
        if(!left.known)
            left.value = left.get_value;
        if(right !is null && !right.known)
            right.value = right.get_value;
        if(op == "OR")
            value = left.value | right.value;
        else if(op == "AND")
            value = left.value & right.value;
        else if(op == "NOT")
            value = ~left.value;
        else if(op == "RSHIFT")
            value = left.value >> right.value;
        else if(op == "LSHIFT")
            value = left.value << right.value;
        else
            value = left.value;
        return value;
    }
}

void main()
{
    writeln("part1 ", part1);
    writeln("part2 ", part2);
}
auto part1()
{
    Wire[string] map = create_wires(lines("file.txt"));
    return map["a"].get_value & 0x0000FFFF;
}
auto part2()
{
    Wire[string] map = create_wires(lines("file.txt"));
    map["b"].set(part1);
    return map["a"].get_value & 0x0000FFFF;
}
Wire[string] create_wires(string[] strs)
{
    Wire[string] map;
    foreach(line; strs)
    {
        auto tokens = line.split(" ").filter!(x => x != "->").array;
        if(tokens[0] == "NOT")
        {
            if(tokens[1] !in map)
                map[tokens[1]] = new Wire(tokens[1]);
            if(tokens[2] !in map)
                map[tokens[2]] = new Wire(tokens[2]);
            map[tokens[2]].left = map[tokens[1]];
            map[tokens[2]].op = "NOT";
        }
        else if(tokens.length == 2)
        {
            if(tokens[0] !in map)
                map[tokens[0]] = new Wire(tokens[0]);
            if(tokens[1] !in map)
                map[tokens[1]] = new Wire(tokens[1]);
            map[tokens[1]].left = map[tokens[0]];
        }
        else
        {
            if(tokens[0] !in map)
                map[tokens[0]] = new Wire(tokens[0]);
            if(tokens[2] !in map)
                map[tokens[2]] = new Wire(tokens[2]);
            if(tokens[3] !in map)
                map[tokens[3]] = new Wire(tokens[3]);
            map[tokens[3]].left = map[tokens[0]];
            map[tokens[3]].right = map[tokens[2]];
            map[tokens[3]].op = tokens[1];
        }
    }
    foreach(ref wire; map)
        if(wire.name.isNumeric)
            wire.set(wire.name.to!int);
    return map;
}
auto lines(string file)
{
    File handle = File(file, "r");
    scope(exit)
        handle.close;
    return handle.byLine.map!(x => x.to!string).array;
}