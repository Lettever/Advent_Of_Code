import std;

bool isInvalid(string str) {
    ulong i = str.length / 2;
    return str[0..i] == str[i..$];
}

bool helper(string str, string sub) {
    if (str.length % sub.length != 0) return false;
    for (int i = 0; i < str.length; i += sub.length) {
        string temp = str[i..i + sub.length];
        if (temp != sub) return false;
    }
    return true;
}

bool isSequence(string str) {
    for (ulong i = 1; i <= str.length / 2; i++) {
        string sub = str[0..i];
        if (helper(str, sub)) return true;
    }
    return false;
}

void main() {
    string input = File("input.txt").byLineCopy().array()[0];
    ulong part1 = 0, part2 = 0;

    foreach(x; input.split(",")) {
        string[] f = x.split("-");
        ulong start = f[0].to!ulong;
        ulong end = f[1].to!ulong;
        for(ulong i = start; i <= end; i++) {
            string str = i.to!string;
            if (isInvalid(str)) part1 += i;
            if (isSequence(str)) part2 += i;
            
        }
    }

    writeln(part1);
    writeln(part2);
}