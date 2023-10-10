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
    {
        string line = input.readln.chomp;
        if(line == "")
            break;
        lines ~= line.split(" ").filter!(x => x != "|").array;
    }
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
    string [][]lines;
    while(!input.eof)
    {
        /*
            a -> [0, 2, 3, 5, 6, 7, 8, 9]    -> 8
            b -> [0, 4, 5, 6, 8, 9]          -> 6
            c -> [0, 1, 2, 3, 4, 7, 8, 9]    -> 8
            d -> [2, 3, 4, 5, 6, 8, 9]       -> 7
            e -> [0, 2, 6, 8]                -> 4
            f -> [0, 1, 3, 4, 5, 6, 7, 8, 9] -> 9
            g -> [0, 2, 3, 5, 6, 8, 9]       -> 7

            0 -> abcefg  -> 6
            1 -> cf      -> 2
            2 -> acdeg   -> 5
            3 -> acdfg   -> 5
            4 -> bcdf    -> 4
            5 -> abdfg   -> 5
            6 -> abdefg  -> 6
            7 -> acf     -> 3
            8 -> abcdefg -> 8
            9 -> abcdfg  -> 7
        */
        string line = input.readln.chomp;
        if(line == "")
            break;
        lines ~= line.split(" ").filter!(x => x != "|").array;
    }
    input.close;
    
    const string []numbers_to_crt = [
            "abcefg",
            "cf",
            "acdeg",
            "acdfg",
            "bcdf",
            "abdfg",
            "abdefg",
            "acf",
            "abcdefg",
            "abcdfg"];
    foreach(i; numbers_to_crt)
        writeln(i);
    return 0;
}