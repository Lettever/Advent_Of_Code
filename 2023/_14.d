import std;

void main()
{
    writeln("part1 ", part1);
    writeln("part2 ", part2);
}
auto part1()
{
    auto grid = lines("file.txt").map!(x => x.dup).array;
    move_north(grid);
    return grid.calc_stress;
}
auto part2()
{
    char[][] grid1 = lines("file.txt").map!(v => v.dup).array;
    char[][] grid2 = lines("file.txt").map!(v => v.dup).array;
    int cycles = 0;
    int length = 0;
    while(cycles < 1_000_000_000)
    {
        cycle(grid1);
        cycle(grid2);
        cycle(grid2);
        cycles++;
        if(grid1 == grid2)
        {
            do
            {
                cycle(grid1);
                length++;
            }while(grid1 != grid2);
            break;
        }
    }
    foreach(i; 0 .. (1_000_000_000 - cycles) % length)
        cycle(grid1);
    return grid1.calc_stress;
}
void cycle(char[][] grid)
{
    move_north(grid);
    move_west(grid);
    move_south(grid);
    move_east(grid);
}
void move_north(char[][] grid)
{
    for(int i = 0; i < grid.length; i++)
        for(int j; j < grid[i].length; j++)
            if(grid[i][j] == 'O')
            {
                int k = i;
                while(k > 0 && grid[k - 1][j] == '.')
                    k--;
                grid[i][j] = '.';
                grid[k][j] = 'O';
            }
}
void move_west(char[][] grid)
{
    foreach(i; 0 .. grid.length)
        foreach(j; 0 .. grid[0].length)
            if(grid[i][j] == 'O')
            {
                int k = j;
                while(k > 0 && grid[i][k - 1] == '.')
                    k--;
                grid[i][j] = '.';
                grid[i][k] = 'O';                
            }
}
void move_south(char[][] grid)
{
    foreach_reverse(i; 0 .. grid.length)
        foreach(j; 0 .. grid[0].length)
            if(grid[i][j] == 'O')
            {
                int k = i;
                while(k < grid.length - 1U && grid[k + 1][j] == '.')
                    k++;
                grid[i][j] = '.';
                grid[k][j] = 'O';
            }
}
void move_east(char[][] grid)
{
    foreach(i; 0 .. grid.length)
        foreach_reverse(j; 0 .. grid[0].length)
            if(grid[i][j] == 'O')
            {
                int k = j;
                while(k < grid[0].length - 1U && grid[i][k + 1] == '.')
                    k++;
                grid[i][j] = '.';
                grid[i][k] = 'O';                
            }
}
int calc_stress(char[][] grid)
{
    int total;
    for(int i = 0; i < grid.length; i++)
        for(int j = 0; j < grid[i].length; j++)
            if(grid[i][j] == 'O')
                total += grid.length - i;
    return total;
}
auto lines(string file)
{
    File handle = File(file, "r");
    scope(exit)
        handle.close;
    return handle.byLine.map!(x => x.to!string).array;
}