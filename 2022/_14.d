import std;

void main()
{
    writeln("part1 ", solve(1));
    writeln("part2 ", solve(2));
}
int solve(int part)
{
    auto input = lines("input.txt").map!(x => x.split(" -> ").map!(y => y.split(",").to!(int[])).array).array;
    char[int][int] space;
    int max_y = 0;
    auto drop = part == 1 ? &part1 : &part2;
    foreach(line; input)
    {
        foreach(coords; line.slide(2))
        {
            int x1 = coords[0][0], y1 = coords[0][1];
            int x2 = coords[1][0], y2 = coords[1][1];
            max_y = max(y1, y2, max_y);
            int dx = x2 - x1, dy = y2 - y1;
            if(dx != 0)
                dx /= abs(dx);
            if(dy != 0)
                dy /= abs(dy);
            while((x1 != x2) || (y1 != y2))
            {
                space[y1][x1] = 'o';
                x1 += dx;
                y1 += dy;
            }
            space[y2][x2] = 'o';
        }
    }
    int grains = part - 1;
    while(drop(space, max_y))
        grains++;
    return grains;
}
bool part1(char[int][int] space, int max_y)
{
    int x = 500, y = 0;
    falling:
    while(y < max_y)
    {
        int new_y = y + 1;
        foreach(new_x; [x, x - 1, x + 1])
        {
            if(!space.contains(new_y, new_x))
            {
                y = new_y;
                x = new_x;
                continue falling;
            }
        }
        break;
    }
    space[y][x] = 's';
    return y < max_y;
}
bool part2(char[int][int] space, int max_y)
{
    int x = 500, y = 0;
    falling:
    while(y + 1 != max_y + 2)
    {
        int new_y = y + 1;
        foreach(new_x; [x, x - 1, x + 1])
        {
            if(new_y)
            if(!space.contains(new_y, new_x))
            {
                y = new_y;
                x = new_x;
                continue falling;
            }
        }
        break;
    }
    space[y][x] = 's';
    return tuple(x, y) != tuple(500, 0);
}
bool contains(Map, Key...)(Map map, Key keys) {
    foreach(key; keys)
        if(key in map)
            return contains(map[key], keys[1 .. $]);
        else
            return false;
    return true;
}
auto lines(string file)
{
    File handle = File(file, "r");
    scope(exit)
        handle.close;
    return handle.byLine.map!(x => x.to!string).array;
}
