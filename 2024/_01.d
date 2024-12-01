import std;

void main() {
	int[] arr1 = [];
	int[] arr2 = [];
	foreach(line; File("input.txt").byLineCopy(No.keepTerminator, "\n")) {
		int[] l = line.split().to!(int[]);
		if(l.length != 2) {
			continue;
		}
		arr1 ~= l[0];
		arr2 ~= l[1];
	}
	sort!((a, b) => a < b, SwapStrategy.stable)(arr1);
	sort!((a, b) => a < b, SwapStrategy.stable)(arr2);
	int part1 =
		zip(arr1, arr2)
		.map!(x => abs(x[0] - x[1]))
		.sum();
	writeln(part1);
	int[int] count = arr2.fold!((acc, x) {
		acc[x] += 1;
		return acc;
	})(int[int].init);
	int part2 = arr1.fold!((acc, x) => acc + x * count.get(x, 0))(0);
	writeln(part2);
}
