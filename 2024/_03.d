import std;

void main() {
    string text = readText("input.txt");
    string regex = r"mul\((-?\d+),(-?\d+)\)";
    int part1 = matchAll(text, regex)
        .map!((x) => [x[1].to!int, x[2].to!int])
        .fold!((acc, x) => acc + x[0] * x[1])(0);
    writeln(part1);
    bool enabled = true;
    regex = "(?:" ~ regex ~ ")" ~  r"|(?:do\(\))|(?:don't\(\))";
    RegexMatch!string matches = matchAll(text, regex);
    int part2 = 0;
    foreach (capture; matches) {
        if (capture[0] == "do()") {
            enabled = true;
        } else if (capture[0] == "don't()") {
            enabled = false;
        } else if (enabled) {
            part2 += capture[1].to!int * capture[2].to!int;
        }
    }
    writeln(part2);
}