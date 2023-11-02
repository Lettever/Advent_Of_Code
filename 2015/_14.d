import std.stdio;
import std.string;
import std.format;
import std.algorithm;
import std.format;

struct Reindeer
{
    string name;
    int speed, max, rest_time;
    int time, points, distance;
    bool is_resting = false;
    this(string n, int a, int b, int c)
    {
        name = n;
        speed = a;
        max = b;
        rest_time = c;
        time = max;
    }
    /*
        int time = reindeer.max;
        foreach(_ ; 0 .. seconds)
        {
            if(time == 0)
            {
                reindeer.is_resting = !reindeer.is_resting;
                time = reindeer.is_resting ? reindeer.rest_time : reindeer.max;
            }
            if(!reindeer.is_resting)
                reindeer.distance += reindeer.speed;
            time--;
        }
    */
    void advance()
    {
        if(time == 0)
        {
            is_resting = !is_resting;
            time = is_resting ? rest_time : max;
        }
        if(!is_resting)
            distance += speed;
        time--;
    }
}
void main()
{
    writeln("part1 ", part1);
    writeln("part2 ", part2);
}
int part1()
{
    File input = File("file.txt", "r");
    Reindeer []reindeers;
    while(!input.eof)
    {
        int speed, max, rest_time;
        string name;
        input.readln.chomp.formattedRead(
            "%s can fly %d km/s for %d seconds, but then must rest for %d seconds.",
            name, speed, max, rest_time);
        reindeers ~= Reindeer(name, speed, max, rest_time);
    }
    input.close;
    int []dists;
    foreach(c; reindeers)
        dists ~= max_distance(c);
    return dists.sort[$ - 1];
}
int part2()
{
    File input = File("file.txt", "r");
    Reindeer []reindeers;
    while(!input.eof)
    {
        int speed, max, rest_time;
        string name;
        input.readln.chomp.formattedRead(
            "%s can fly %d km/s for %d seconds, but then must rest for %d seconds.",
            name, speed, max, rest_time);
        reindeers ~= Reindeer(name, speed, max, rest_time);
    }
    input.close;
    foreach(_; 0 .. 2503)
    {
        foreach(ref reindeer; reindeers)
            reindeer.advance;
        reindeers[max_index(reindeers)].points++;
    }
    int []points;
    foreach(c; reindeers)
        points ~= c.points;
    return sort(points)[$ - 1];
}
int max_distance(Reindeer reindeer)
{
    foreach(_ ; 0 .. 2503)
        reindeer.advance;
    return reindeer.distance;
}
int max_index(Reindeer []array)
{
    int max = 0;
    for(int i = 1; i < array.length; i++)
        if(array[i].distance > array[max].distance)
            max = i;
    return max;
}