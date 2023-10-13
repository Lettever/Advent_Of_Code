import std.stdio;
import std.string;
import std.algorithm;
import std.conv;
import std.array;
import std.typecons;

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
        string []segments = input.readln.chomp.split(" ").filter!(x => x != "|")
                            .map!(x => x.to!(dchar[]).sort.to!string).array;

        string []hints = segments[0 .. $ - 4];
        string []display = segments[$ - 4 .. $];
        string one = segments.filter!(x => x.length == 2).array[0];
        string four = segments.filter!(x => x.length == 4).array[0];
        int [string]undecoder;

        foreach(hint; hints)
        {
            auto cmp = tuple(hint.length, hint.match_segments(one), hint.match_segments(four));
            undecoder[hint] =
                cmp == tuple(2, 2, 2) ? 1 :
                cmp == tuple(4, 2, 4) ? 4 :
                cmp == tuple(3, 2, 2) ? 7 :
                cmp == tuple(7, 2, 4) ? 8 :
                cmp == tuple(5, 1, 2) ? 2 :
                cmp == tuple(5, 2, 3) ? 3 :
                cmp == tuple(5, 1, 3) ? 5 :
                cmp == tuple(6, 1, 3) ? 6 :
                cmp == tuple(6, 2, 4) ? 9 :
                cmp == tuple(6, 2, 3) ? 0 : assert(0);
            /*
            auto cmp = tuple(hint.length, hint.match_segments(one), hint.match_segments(four));
            if(cmp == tuple(2, 2, 2))           undecoder[hint] = 1;
            else if(cmp == tuple(4, 2, 4))      undecoder[hint] = 4;
            else if(cmp == tuple(3, 2, 2))      undecoder[hint] = 7;
            else if(cmp == tuple(7, 2, 4))      undecoder[hint] = 8;
            else if(cmp == tuple(5, 1, 2))      undecoder[hint] = 2;
            else if(cmp == tuple(5, 2, 3))      undecoder[hint] = 3;
            else if(cmp == tuple(5, 1, 3))      undecoder[hint] = 5;
            else if(cmp == tuple(6, 1, 3))      undecoder[hint] = 6;
            else if(cmp == tuple(6, 2, 4))      undecoder[hint] = 9;
            else if(cmp == tuple(6, 2, 3))      undecoder[hint] = 0;
            else assert(0);
            */
            /*
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
            */
        }
        foreach(value; display)
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
