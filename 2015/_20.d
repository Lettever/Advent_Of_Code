import std;

void main()
{
    writeln("part1 ", solve(&part1));
    writeln("part2 ", solve(&part2));
}
long solve(long function(long) presents)
{
    File input = File("file.txt", "r");
    int min = input.readln.chomp.to!int;
    input.close;
    long house = 0;
    while(presents(house) <= min)
        house++;
    return house;
}
long part1(long house)
{
    long max = sqrt(house.to!real).to!long;
    long sum;
    for(int i = 1; i <= max; i++)
        if(house % i == 0)
        {
            sum += i;
            if(i != house / i)
                sum += house / i;
        }
    return sum * 10;
}
long part2(long house)
{
    long sum;
    long d = house.to!real.sqrt.to!long;
    for (int i = 1; i <= d; i++)
    {
        if (house % i == 0)
        {
            if(i <= 50)
                sum += house / i;
            if(house / i <= 50)
                sum += i;
        }
        
    }
    return sum * 11;
}