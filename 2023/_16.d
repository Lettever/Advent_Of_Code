import std;;

auto UP = [-1, 0], RIGHT = [0, 1], DOWN = [1, 0], LEFT = [0, -1];

void main()
{
    writeln("part1 ", part1);
    writeln("part2 ", part2);
}

auto part1()
{
    return solve(lines("input.txt"));
}
auto part2()
{
    auto input = lines("input.txt");
    int result;
    foreach(i; 0 .. input.length)
    {
        foreach(dir; [LEFT, RIGHT, DOWN, UP])
        {
            result = max(result, solve(input, i, 0, dir));
            result = max(result, solve(input, i, input[0].length - 1U, dir));
        }
    }
    foreach(j; 0 .. input[0].length)
    {
        foreach(dir; [LEFT, RIGHT, DOWN, UP])
        {
            result = max(result, solve(input, 0, j, dir));
            result = max(result, solve(input, input.length - 1U, j, dir));
        }
    }
    return result;
}
auto lines(string file)
{
    File handle = File(file, "r");
    scope(exit)
        handle.close;
    return handle.byLine.map!(x => x.to!string).array;
}
int solve(string[] input, int i2 = 0, int j2 = 0, int[] dir2 = RIGHT)
{
    int total;
    auto visited = input.map!(x => x.map!(y => tuple(false, [[0, 0]])).array).array;
    void move_light(string[] input, ref Tuple!(bool, int[][])[][] visited, int i, int j, int[] dir = dir2)
    {
        while((0 <= i && i < input.length) && (0 <= j && j < input[0].length))
        {
            if(visited[i][j][0] == true && visited[i][j][1].canFind(dir))
                return;
            if(!visited[i][j][0])
                total++;
            visited[i][j][0] = true;
            visited[i][j][1] ~= dir;
            if(input[i][j] == '\\')
            {
                if(dir == UP)
                    dir = LEFT;
                else if(dir == LEFT)
                    dir = UP;
                else if(dir == DOWN)
                    dir = RIGHT;
                else if(dir == RIGHT)
                    dir = DOWN;
            }
            else if(input[i][j] == '/')
            {
                if(dir == UP)
                    dir = RIGHT;
                else if(dir == RIGHT)
                    dir = UP;
                else if(dir == DOWN)
                    dir = LEFT;
                else if(dir == LEFT)
                    dir = DOWN;
            }
            else if(input[i][j] == '|')
            {
                if(dir == LEFT || dir == RIGHT)
                {
                    move_light(input, visited, i, j, UP);
                    move_light(input, visited, i, j, DOWN);
                    return;
                }

            }
            else if(input[i][j] == '-')
            {
                if(dir == UP || dir == DOWN)
                {
                    move_light(input, visited, i, j, LEFT);
                    move_light(input, visited, i, j, RIGHT);
                    return;
                }
            }
            i += dir[0];
            j += dir[1];

        }
    }
    move_light(input, visited, i2, j2);
    return total;
}
