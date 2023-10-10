import std.stdio;
import std.string;
import std.conv;
import std.algorithm;

class Board
{
    int [5][5]board;
    bool [5][5]marked;
    void mark(int number)
    {
        for(int i = 0; i < 5; i++)
            for(int j = 0; j < 5; j++)
                if(this.board[i][j] == number)
                    this.marked[i][j] = true;
    }
    private bool is_line_true(int line)
    {
        for(int i = 0; i < 5; i++)
            if(this.marked[line][i] == false)
                return false;
        return true;
    }
    private bool is_collumn_true(int collumn)
    {
        for(int i = 0; i < 5; i++)
            if(this.marked[i][collumn] == false)
                return false;
        return true;
    }
    bool game_over()
    {
        for(int i = 0; i < 5; i++)
        {
            if(this.is_line_true(i))
                return true;
            else if(this.is_collumn_true(i))
                return true;
        }
        return false;
    }
    int sum_of_unmarked_numbers()
    {
        int sum = 0;
        for(int i = 0; i < 5; i++)
            for(int j = 0; j < 5; j++)
                if(this.marked[i][j] == false)
                    sum += this.board[i][j];
        return sum;
    }
}
void main()
{
    writeln("part1 ", part1);
    writeln("part2 ", part2);
}
string [][]remove_spaces(string[] strings)
{
    string [][]result;
    foreach (key; strings)
        result ~= key.split(" ");
    foreach(ref line; result)
        foreach_reverse(index, key; line)
            if(key == "")
            {
                line.remove(index);
                line = line[0 .. $ - 1];
            }
    return result;
}
Board create_board(File input)
{
    Board result = new Board;
    string [5]lines;
    foreach(ref key; lines)
        key = input.readln.chomp;
    input.readln;
    string [][]numbers = remove_spaces(lines);
    for(int i = 0; i < 5; i++)
        for(int j = 0; j < 5; j++)
            result.board[i][j] = to!int(numbers[i][j]);
    return result;
}
int part1()
{
    File input = File("file.txt", "r");
    string []string_of_numbers = input.readln.chomp.split(",");
    input.readln;
    int []numbers;
    foreach(key; string_of_numbers)
        numbers ~= to!int(key);
    Board []boards;
    while(!input.eof)
        boards ~= create_board(input);
    input.close;
    foreach(number; numbers)
        foreach(board; boards)
        {
            board.mark(number);
            if(board.game_over)
                return board.sum_of_unmarked_numbers * number;
        }
    return -1;
}
int part2()
{
    File input = File("file.txt", "r");
    string []string_of_numbers = input.readln.chomp.split(",");
    input.readln;
    int []numbers;
    foreach(key; string_of_numbers)
        numbers ~= to!int(key);
    Board []boards;
    while(!input.eof)
        boards ~= create_board(input);
    input.close;
    foreach(number; numbers)
    {
        if(boards.length != 1)
            foreach_reverse(index, ref board; boards)
            {
                board.mark(number);
                if(board.game_over){
                    boards.remove(index);
                    boards.length--;
                }
            }
        else
        {
            boards[0].mark(number);
            if(boards[0].game_over)
                return boards[0].sum_of_unmarked_numbers * number;
        }
    }
    return -1;
}