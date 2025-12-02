import std;

// R = +=
// L = -=

int mod(int x, int y) {
    int r = x % y;
    if (r < 0) r += y;
    return r;
}

void main() {
    string[] lines = File("input.txt").byLineCopy().array();
    int cnt = 0;
    int p = 50;
    foreach(line; lines) {
        int num = line[1..$].strip().to!(int);
        if (line[0] == 'L') num *= -1;
        p = mod(p + num, 100);
        if (p == 0) cnt ++;
    }
    writeln(cnt);

    p = 50;
    cnt = 0;
    foreach(line; lines) {
        int num = line[1..$].strip().to!(int);
        if (line[0] == 'L') num *= -1;
        
        int n = p + num;
        cnt += abs(n / 100) + (n <= 0 && p != 0);
        p = mod(n, 100);
    }
    
    writeln(cnt);
}
