import std.stdio;
import std.string;
import std.algorithm;
import std.conv;
import std.array;

void main()
{
    writeln("part1 ", part1);
    writeln("part2 ", part2);
}
int part1()
{
    File input = File("file.txt", "r");
    string [][]lines;

    while(!input.eof)
        lines ~= input.readln.chomp.split(" ").filter!(x => x != "|").array;
    input.close;

    int sum = 0;
    for(int i = 0; i < lines.length; i++)
        for(int j = 10; j < lines[i].length; j++)
        {
            switch(lines[i][j].length)
            {
                case 2, 4, 3, 7 : sum++; goto default;
                default:
            }
        }

    return sum;
}
int part2()
{
    File input = File("file.txt", "r");
    int result;

    while(!input.eof)
    {
        int sum;
        string []a = input.readln.chomp.split(" ").filter!(x => x != "|").array;
        foreach(ref b; a)
            b = b.to!(dchar[]).sort.to!string;

        string []line = a[0 .. $ - 4];
        string []b = a[$ - 4 .. $];
        string one = line.filter!(x => x.length == 2).array[0];
        string four = line.filter!(x => x.length == 4).array[0];
        int [string]decoded;
        /*
            number length match(1) match(4)
                 0      7        2        3
                 1      2        2        2
                 2      5        1        2
                 3      5        2        3
                 4      4        2        4
                 5      5        1        3
                 6      6        1        3
                 7      3        2        2
                 8      7        2        4
                 9      6        2        4
        */
        foreach(i; line)
        {
            if(i.length == 2)
                decoded[i] = 1;
            else if(i.length == 4)
                decoded[i] = 4;
            else if(i.length == 3)
                decoded[i] = 7;
            else if(i.length == 7)
                decoded[i] = 8;
            else if(i.length == 5)
                if(i.match_chars(one) == 1 && i.match_chars(four) == 2)
                    decoded[i] = 2;
                else if(i.match_chars(one) == 2 && i.match_chars(four) == 3)
                    decoded[i] = 3;
                else if(i.match_chars(one) == 1 && i.match_chars(four) == 3)
                    decoded[i] = 5;
                else
                    assert(0);
            else if(i.length == 6)
                if(i.match_chars(one) == 1 && i.match_chars(four) == 3)
                    decoded[i] = 6;
                else if(i.match_chars(one) == 2 && i.match_chars(four) == 4)
                    decoded[i] = 9;
                else if(i.match_chars(one) == 2 && i.match_chars(four) == 3)
                    decoded[i] = 0;
                else
                    assert(0);
            else assert(0);
        }
        foreach(key, value; b)
            sum = sum * 10 + decoded[value];
        result += sum;
    }
    input.close;
    return result;
}
int match_chars(string str1, string str2)
{
    int sum;
    foreach(char1; str1)
        foreach(char2; str2)
            if(char1 == char2)
                sum++;
    return sum;
}