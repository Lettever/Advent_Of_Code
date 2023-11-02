import std;

void main()
{
    writeln("part1 ", solve(1));
    writeln("part2 ", solve(2));
}
int solve(int part)
{
    string []ops;
    File input = File("file.txt", "r");
    while(!input.eof)
        ops ~= input.readln.chomp;
    input.close;
    int i;
    int [char]register;
    register['a'] = part - 1;
    register['b'] = 0;
    while(i < ops.length)
    {
        string comm = ops[i];
        switch (comm[0 .. 3])
        {
            case "hlf":
                register[comm[$ - 1]] /= 2;
                i++;
                break;
            case "tpl":
                register[comm[$ - 1]] *= 3;
                i++;
                break;
            case "inc":
                register[comm[$ - 1]] += 1;
                i++;
                break;
            case "jmp":
                i += comm.split(" ").array[1].to!int;
                break;
            case "jie":
                if(register[comm[4]] % 2 == 0)
                    i += comm.split(", ").array[1].to!int;
                else
                    i++;
                break;
            case "jio":
                if(register[comm[4]] == 1)
                    i += comm.split(", ").array[1].to!int;
                else
                    i++;
                break;
            default:
                assert(false);
        }
    }
    return register['b'];
}