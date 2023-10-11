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
    int sum = 0;

    while(!input.eof)
        foreach(str; input.readln.chomp.split(" ").filter!(x => x != "|").array[$ - 4 .. $])
            switch(str.length)
            {
                case 2, 4, 3, 7 : sum++; break;
                default :
            }
    input.close;
 
    return sum;
}
int part2()
{
    File input = File("file.txt", "r");
    int result;

    while(!input.eof)
    {
        int sum;
        string []segments = input.readln.chomp.split(" ").filter!(x => x != "|").array.map!(x => x.to!(dchar[]).sort.to!string).array;

        string []hints = segments[0 .. $ - 4];
        string []display = segments[$ - 4 .. $];
        string one = hints.filter!(x => x.length == 2).array[0];
        string four = hints.filter!(x => x.length == 4).array[0];
        int [string]undecoder;
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
        foreach(i; hints)
        {
            if(i.length == 2)
                undecoder[i] = 1;
            else if(i.length == 4)
                undecoder[i] = 4;
            else if(i.length == 3)
                undecoder[i] = 7;
            else if(i.length == 7)
                undecoder[i] = 8;
            else if(i.length == 5)
                if(i.match_chars(one) == 1 && i.match_chars(four) == 2)
                    undecoder[i] = 2;
                else if(i.match_chars(one) == 2 && i.match_chars(four) == 3)
                    undecoder[i] = 3;
                else if(i.match_chars(one) == 1 && i.match_chars(four) == 3)
                    undecoder[i] = 5;
                else
                    assert(0);
            else if(i.length == 6)
                if(i.match_chars(one) == 1 && i.match_chars(four) == 3)
                    undecoder[i] = 6;
                else if(i.match_chars(one) == 2 && i.match_chars(four) == 4)
                    undecoder[i] = 9;
                else if(i.match_chars(one) == 2 && i.match_chars(four) == 3)
                    undecoder[i] = 0;
                else
                    assert(0);
            else assert(0);
        }
        foreach(key, value; display)
            sum = sum * 10 + undecoder[value];
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