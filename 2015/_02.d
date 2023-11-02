import std.stdio;
import std.string;
import std.format;
import std.algorithm;

void main()
{
    writeln(area(4, 2, 3));
    writeln("part1 ", part1);
    writeln("part2 ", part2);
}
int part1()
{
    File input = File("file.txt", "r");
    int sum;
    while(!input.eof)
    {
        int l, w, h;
        input.readln.chomp.formattedRead("%dx%dx%d", l, w, h);
        sum += area(l, w, h) + min2(l, w, h);
    }
    input.close;
    return sum;
}
int part2()
{
    File input = File("file.txt", "r");
    int sum;
    while(!input.eof)
    {
        int []sides;
        int [3]stupid_language;
        input.readln.chomp.formattedRead("%dx%dx%d", stupid_language[0], stupid_language[1], stupid_language[2]);
        foreach(key; stupid_language)
            sides ~= key;
        sides.sort;
        sum += 2 * (sides[0] + sides[1]) + sides[0] * sides[1] * sides[2];
    }
    input.close;
    return sum;
}   
int area(int l, int w, int h) {return 2 * (l * w +l * h + w * h);}
int min2(int l, int w, int h) { return min(l * w, l * h, w * h);}