import std.stdio;
import std.string;
import std.format;
import std.algorithm;

struct Point
{
    int i, j;
    this(int j, int i)
    {
        this.j = j;
        this.i = i;
    }
}
struct Fold
{
    char axis;
    int fold;
    this(char axis, int fold)
    {
        this.axis = axis;
        this.fold = fold;
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
    Point []points;
    Fold []folds;

    while(!input.eof)
    {
        string line = input.readln.chomp;
        if(line == "")
            break;
        int x, y;
        line.formattedRead("%d,%d", x, y);
        points ~= Point(x, y);
    }
    while(!input.eof)
    {
        char axis;
        int fold;
        input.readln.chomp.formattedRead("fold along %c=%d", axis, fold);
        folds ~= Fold(axis, fold);
        break;
    }
    input.close;
    foreach(ref point; points)
        point = point.apply_folds(folds);
    int max_x, max_y;
    foreach(point; points)
    {
        if(point.i > max_y)
            max_y = point.i;

        if(point.j > max_x)
            max_x = point.j;
    }
    char [][]matrix = new char[][](max_y + 1, max_x + 1);
    foreach(ref a; matrix)
        a[] = '.';
    int count;
    foreach(point; points)
    {
        if(matrix[point.i][point.j] == '.')
            count++;
        matrix[point.i][point.j] = '#';
    }
    return count;

}
int part2()
{
    File input = File("file.txt", "r");
    Point []points;
    Fold []folds;

    while(!input.eof)
    {
        string line = input.readln.chomp;
        if(line == "")
            break;
        int x, y;
        line.formattedRead("%d,%d", x, y);
        points ~= Point(x, y);
    }
    while(!input.eof)
    {
        char axis;
        int fold;
        input.readln.chomp.formattedRead("fold along %c=%d", axis, fold);
        folds ~= Fold(axis, fold);
    }
    input.close;
    foreach(ref point; points)
        point = point.apply_folds(folds);
    int max_x, max_y;
    foreach(point; points)
    {
        if(point.i > max_y)
            max_y = point.i;

        if(point.j > max_x)
            max_x = point.j;
    }
    char [][]matrix = new char[][](max_y + 1, max_x + 1);
    foreach(ref a; matrix)
        a[] = '.';
    int count;
    foreach(point; points)
    {
        if(matrix[point.i][point.j] == '.')
            count++;
        matrix[point.i][point.j] = '#';
    }
    File output = File("output.txt", "w");
    foreach(a; matrix)
        output.writeln(a);
    output.close;
    return count;
}
Point apply_fold(Point point, Fold fold)
{
    if(fold.axis == 'y')
    {
        if(point.i >= fold.fold)
            point.i = 2 * fold.fold - point.i;
        return point;
    }
    if(point.j >= fold.fold)
        point.j = 2 * fold.fold - point.j;
    return point;
}
Point apply_folds(Point point, Fold []folds)
{
    foreach(ref fold; folds)
        point = point.apply_fold(fold);
    return point;
}
// 01234567890
// ....#..|..#