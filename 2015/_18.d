import std;
struct Position
{
    int i, j;
    this(int i, int j)
    {
        this.i = i;
        this.j = j;
    }
}
void main()
{
    writeln("part1 ", part1);
    writeln("part2 ", part2);
}
int part1()
{
    int [][]lights;
    File input = File("test.txt", "r");
    while(!input.eof)
        lights ~= input.readln.chomp.to!(char[]).map!(x => (x == '#').to!int).array;
    input.close;
    foreach(_; 0 .. 4)
    {
        for(int i = 0; i < lights.length; i++)
            for(int j = 0; j < lights[i].length; j++)
            {
                auto a = around(lights, i, j);
                if(lights[i][j] == 1)
                {
                    int count = a.sum;
                    if(count == 2 || count == 3)
                        lights[i][j] += 2;
                }
                else if(lights[i][j] == 0)
                {
                    if(lights.around(i, j).sum == 3)
                        lights[i][j] += 2;
                }
                else
                    writeln("erro");
            }
        for(int i = 0; i < lights.length; i++)
            for(int j = 0; j < lights[i].length; j++)
                if(lights[i][j] == 2)
                    lights[i][j] = 1;
                else if(lights[i][j] == 3)
                    lights[i][j] = 0;
            /*
                A light which is on stays on when 2 or 3 neighbors are on, and turns off otherwise.
                A light which is off turns on if exactly 3 neighbors are on, and stays off otherwise.
            */
    }
    int sum;
    for(int i = 0; i < lights.length; i++)
        for(int j = 0; j < lights[i].length; j++)
            sum += lights[i][j];
    return sum;
}
//4905 is too high
int part2()
{
    File input = File("file.txt", "r");
    input.close;
    return 0;
}
int[] around(int [][]matrix, int i, int j)
{
    int []a;
    for(int di = i - 1; di <= i + 1; di++)
        for(int dj = j - 1; dj <= j + 1; dj++)
        {
            if(di == i && dj == j)
                continue;
            if(in_range(di, 0, matrix.length.to!int) && in_range(dj, 0, matrix[0].length.to!int))
            {
                if(matrix[di][dj] == 2)
                    a ~= 1;
                else if(matrix[di][dj] == 3)
                    a ~= 0;
                else
                    a ~= matrix[di][dj];
            }
        }
    return a;
}
bool in_range(int num, int min, int max)
{
    return min <= num && num < max;
} 