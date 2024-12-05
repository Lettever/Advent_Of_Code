import std;

void main() {
    auto directions = [
        [1, 0], [0, 1],
        [-1, 0], [0, -1],
        [1, 1], [1, -1],
        [-1, 1], [-1, -1],    
    ];
    string[] lines = File("input.txt").byLineCopy().array();
    int part1 = 0;
    for (int i = 0; i < lines.length; i++) {
        for (int j = 0; j < lines[0].length; j++) {
            if (lines[i][j] != 'X') {
                continue;
            }
            part1 += directions.count!(x => getString(lines, i, j, x) == "XMAS"); 
        }
    }
    writeln(part1);
    int part2 = 0;
    for (int i = 1; i < lines.length - 1; i++) {
        for (int j = 1; j < lines[0].length - 1; j++) {
            if (lines[i][j] != 'A') {
                continue;
            }
            bool b1 = (
                (lines[i - 1][j - 1] == 'M' && lines[i + 1][j + 1] == 'S') ||
                (lines[i - 1][j - 1] == 'S' && lines[i + 1][j + 1] == 'M')
            );
            bool b2 = (
                (lines[i + 1][j - 1] == 'M' && lines[i - 1][j + 1] == 'S') ||
                (lines[i + 1][j - 1] == 'S' && lines[i - 1][j + 1] == 'M')
            );
            part2 += b1 && b2;
        }
    }
    writeln(part2);
}

string getString(string[] lines, int i, int j, int[] direction) {
    string res = "";
    for (int k = 0; k < 4; k++) {
        if (i < 0 || j < 0 || j >= lines[0].length || i >= lines.length) {
            return "";
        }
        res ~= lines[i][j];
        i += direction[0];
        j += direction[1];
    }
    return res;
}
