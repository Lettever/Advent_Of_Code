import std.stdio;
import std.conv;
// line = line.filter!(c => c.isDigit || c == '-' || c == '."); 
// removes evrything but numbers
void main()
{
    writeln("part1 ", part1);
    writeln("part2 ", part2);
}
int part1()
{
    auto file = File("file.txt", "r");
    int number = 0x7FFFFFFF, increments = 0;
    while(!file.eof)
    {
        auto old_number = number;
        number = string_to_int(file.readln);
        if(number > old_number)
            increments++;
    }
    file.close;
    return increments;
}
int part2()
{
    auto file = File("file.txt", "r");
    int [3]array;
    int sum = 0, increments = 0;
    for(auto i = 0; i < 3; i++)
    {
        array[i] = string_to_int(file.readln);
        sum += array[i];
    }
    while(!file.eof)
    {
        auto old_sum = sum;
        sum -= array[0];
        array[0] = array[1];
        array[1] = array[2];
        array[2] = string_to_int(file.readln);
        sum += array[2];
        if(sum > old_sum)
            increments++;
    }
    file.close;
    return increments;
}
int string_to_int(string s)
{
    int result = 0;
    for(int i = 0; i < s.length; i++)
    {
        if('0' <= s[i] && s[i] <= '9')
            result = result * 10 + s[i] - '0';
        else
            break;
    }
    return result;
}