import std.stdio;
import std.string;
import std.algorithm;

class InvalidCharacter : Exception
{
    this(string msg, string file = __FILE__, size_t line = __LINE__) {
        super(msg, file, line);
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
    int sum = 0;
    while(!input.eof)   
        sum += input.readln.chomp.calculate_score1;
    input.close;
    return sum;
}
ulong part2()
{
    File input = File("file.txt", "r");
    ulong []scores;
    while(!input.eof){
        ulong score = input.readln.chomp.calculate_score2;
        if(score != 0)
            scores ~= score;
    }
    input.close;
    scores.sort!();
    if(scores.length % 2 == 0)
    {
        ulong mid = scores.length / 2;
        return (scores[mid] + scores[mid - 1]) / 2;
    }
    return scores[scores.length / 2];
}
// 1 3 2
int calculate_score1(string input)
{
    int [char]score = [')' : 3, ']' : 57, '}' : 1197, '>' : 25_137];
    char []stack;
    foreach(character; input)
    {
        switch(character)
        {
            case '(', '[', '{', '<' : stack ~= character; break;
            case ')', ']', '}', '>' : if(stack.last_char != character.other_parentheses) return score[character];
                                      else stack.pop; break;
            default : throw new InvalidCharacter(format("Invalid character found : %c", character));
        }
    }
    return 0;
}
ulong calculate_score2(string input)
{
    ulong [char]score = ['(' : 1, '[' : 2, '{' : 3, '<' : 4];
    char []stack;
    foreach(character; input)
    {
        switch(character)
        {
            //(>
            case '(', '[', '{', '<' : stack ~= character; break;
            case ')', ']', '}', '>' : if(stack.last_char != character.other_parentheses) return 0;
                                      else stack.pop; break;
            default : throw new InvalidCharacter(format("Invalid character found : %c", character));
        }
    }
    ulong sum = 0;
    foreach_reverse(key; stack)
    {
        sum = sum * 5 + score[key];
    }

    return sum;
}
char last_char(char []array) => array[$ - 1];
char[] pop(ref char []array) => array = array[0 .. $ - 1];
char other_parentheses(char parentheses){
    switch(parentheses) {
        case ')' : return '(';
        case ']' : return '['; 
        case '}' : return '{';
        case '>' : return '<';
        case '(' : return ')'; 
        case '[' : return ']';
        case '{' : return '}';
        case '<' : return '>';
        default : throw new InvalidCharacter("Not a parentheses");       
    }
}