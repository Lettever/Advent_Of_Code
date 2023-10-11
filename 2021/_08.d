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
        string []segments = input.readln.chomp.split(" ").filter!(x => x != "|").array
                            .map!(x => x.to!(dchar[]).sort.to!string).array;

        string []hints = segments[0 .. $ - 4];
        string []display = segments[$ - 4 .. $];
        string one = hints.filter!(x => x.length == 2).array[0];
        string four = hints.filter!(x => x.length == 4).array[0];
        int [sting]undecoder;
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
        foreach(hint; hints)
        {
            if(hint.length == 2)
                undecoder[hint] = 1;
            else if(hint.length == 4)
                undecoder[hint] = 4;
            else if(hint.length == 3)
                undecoder[hint] = 7;
            else if(hint.length == 7)
                undecoder[hint] = 8;
            else if(hint.length == 5)
                if(hint.match_segments(one) == 1 && hint.match_segments(four) == 2)
                    undecoder[hint] = 2;
                else if(hint.match_segments(one) == 2 && hint.match_segments(four) == 3)
                    undecoder[hint] = 3;
                else if(hint.match_segments(one) == 1 && hint.match_segments(four) == 3)
                    undecoder[hint] = 5;
                else
                    assert(0);
            else if(hint.length == 6)
                if(hint.match_segments(one) == 1 && hint.match_segments(four) == 3)
                    undecoder[hint] = 6;
                else if(hint.match_segments(one) == 2 && hint.match_segments(four) == 4)
                    undecoder[hint] = 9;
                else if(hint.match_segments(one) == 2 && hint.match_segments(four) == 3)
                    undecoder[hint] = 0;
                else
                    assert(0);
            else
                assert(0);
        }
        foreach(key, value; display)
            sum = sum * 10 + undecoder[value];
        result += sum;
    }
    input.close;
    return result;
}
int match_segments(string str1, string str2)
{
    int sum;
    foreach(char1; str1)
        foreach(char2; str2)
            sum += (char1 == char2);
    return sum;
}
