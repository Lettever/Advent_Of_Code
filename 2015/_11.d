import std.stdio;
import std.string;
import std.format;
import std.algorithm;
import std.range;
import std.conv;

struct Count
{
    char value;
    int freq = 1;
    this(char a)
    {
        value = a;
    }
}
void main()
{
    File input = File("file.txt", "r");
    string password = input.readln.chomp;
    input.close;
    string part1 = next_password(password);
    writeln("part1 ", part1);
    writeln("part2 ", next_password(part1.next));
}
string next_password(string password)
{
    while(!valid(password))
        password = password.next;
    return password;
}
bool valid(string str)
{
    foreach(ch; str)
        if("iol".canFind(ch))
            return false;
    bool flag;
    foreach (key; str.slide(3).map!(x => x.to!string[]).array)
        if(increasing_straight(key))
        {
            flag = true;
            break;
        }
    if(!flag)
        return false;
    Count []array;
    array ~= Count(str[0]);
    for(int i = 1; i < str.length; i++)
        if(str[i] == array[$ - 1].value)
            array[$ - 1].freq++;
        else
            array ~= Count(str[i]);
    int a;
    foreach(elem; array)
        if(elem.freq == 2)
            a++;
    return a == 2;
}
bool increasing_straight(string str)
{
    return (str[2] - str[1] == 1) && (str[1] - str[0] == 1);
}
string next(string str)
{
    auto chars = str.to!(char[]);
    for(int i = str.length - 1U; i >= 0; i--)
    {
        chars[i]++;
        if(chars[i] > 'z')
            chars[i] -= 'z' - 'a' + 1;
        else
            break;
    }
    return chars.to!string;
}