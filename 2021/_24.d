import std;

class Stack
{
    struct Node
    {
        int index, value;
        this(int a, int b)
        {
            index = a;
            value = b;
        }
    }

    int index = 0;
    Node[] stack;
    void push(int value)
    {
        stack ~= Node(index++, value);
    }
    Node pop()
    {
        auto elem = stack[$ - 1];
        stack.popBack;
        return elem;
    }
}
void main()
{
    writeln("part1 ", solve(1));
    writeln("part2 ", solve(2));
    test;
}
auto solve(int part)
{
    int [14]digits;
    auto info = info;
    auto stack = new Stack;
    for(int i = 0; i < info.length; i++)
    {
        stack.push(info[i]);
        if(info[i] < 0)
        {
            auto node1 = stack.pop;
            auto node2 = stack.pop;

            int i1 = node1.index;
            int i2 = node2.index;
            int value = node1.value + node2.value;

            digits[i2] = part == 1 ? min(9 - value, 9) : max(1 - value, 1);
            digits[i1] = digits[i2] + value;
        }
    }
    return digits.to_long;
    //9, 1, 11, 3, -11, 5, 0, -6, 9, -6, -6, -16, -4, -2
}
int[] info()
{
    auto lines = "file.txt".lines;
    int []checks;
    int []offsets;
    
    for(int i = 0; i < lines.length; i++)
        if(lines[i] == "mod x 26")
            checks ~= lines[i + 2].split(" ")[$ - 1].to!int;
        else if(lines[i] == "add y w")
            offsets ~= lines[i + 1].split(" ")[$ - 1].to!int;

    int []result;
    for(int i = 0; i < 14; i++)
        result ~= checks[i] <= 0 ? checks[i] : offsets[i];
    return result;
}
auto lines(string file_name)
{
    string []array;
    File handle = File(file_name, "r");
    while(!handle.eof)
        array ~= handle.readln.chomp;
    handle.close;
    return array;
}
long to_long(int[] digits)
{
    long sum;
    foreach(digit; digits)
        sum = sum * 10 + digit;
    return sum;
}
void test()
{
    auto arr = [9, 1, 11, 3, -11, 5, 0, -6, 9, -6, -6, -16, -4, -2];
    for(int i = 0; i < arr.length; i++)
    {
        if(arr[i] < 0)
        {
            int goBack = 1;
            int j = i;
            while(goBack != 0)
            {
                goBack--;
                j--;
                if(arr[j] < 0)
                    goBack += 2;
            }
            writeln(arr[j], " ", arr[i]);
        }
    }
}
/*
    input[4] = input[3] - 8
    input[7] = input[6] - 6
    input[9] = input[8] + 3
    input[10] = input[5] - 1
    input[11] = input[2] - 5
    input[12] = input[1] - 3
    input[13] = input[0] + 7

    input[0]  = 2
    input[1]  = 9
    input[2]  = 9
    input[3]  = 9
    input[4]  = 1
    input[5]  = 9
    input[6]  = 9
    input[7]  = 3
    input[8]  = 6
    input[9]  = 9
    input[10] = 8
    input[11] = 4
    input[12] = 6
    input[13] = 9
    
*/