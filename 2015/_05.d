import std.stdio;
import std.string;
import std.format;
import std.algorithm;
import std.range;
import std.conv;

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
        sum += is_nice1(input.readln.chomp);
    input.close;
    return sum;
}
int part2()
{
    File input = File("file.txt", "r");
    int sum = 0;
    while(!input.eof)
        sum += is_nice2(input.readln.chomp);
    input.close;
    return sum;
}
bool is_nice1(string word)
{
    foreach(str; ["ab", "cd", "pq", "xy"])
        if(word.canFind(str))
            return false;

    int [char]map = ['a': 0, 'e': 1, 'i': 2, 'o': 3, 'u': 4];
    int [5]vowels;
    bool flag = false;
    for(int i = 0; i < word.length - 1U; i++)
    {
        if(word[i] == word[i + 1])
            flag = true;
        if("aeiou".canFind(word[i]))
            vowels[map[word[i]]]++;
    }
    if("aeiou".canFind(word[$ - 1]))
            vowels[map[word[$ - 1]]]++;
    
    if(!flag)
        return false;
    
    int sum;
    foreach(a; vowels)
        sum += a;
    return sum >= 3;
}

bool is_nice2(string word)
{
    bool flag = false;
    for(int i = 0; i < word.length - 2U; i++)
        if(word[i] == word[i + 2])
        {
            flag = true;
            break;
        }
    if(!flag)
        return false;
    auto windows = word.slide(2).map!(x => x.to!string[]).array;
    for(int i = 0; i < windows.length - 2U; i++)
        for(int j = i + 2; j < windows.length; j++)
            if(windows[i] == windows[j])
                return true;
    return false;
}