import std;

void main() {
	string[][] temp = File("input.txt").byLineCopy().array.split("");
	bool[int][int] rules;
	foreach(t; temp[0]) {
		int[] a = t.split("|").to!(int[]);
		rules[a[0]][a[1]] = true;
	}
	int[][] numbers = temp[1].map!(x => x.split(",").to!(int[])).array();
	
	int part1 = numbers
		.filter!(x => isValid(x, rules))
		.map!(x => x[$ / 2])
		.sum();
	writeln(part1);
	
	auto part2 = numbers
		.filter!(x => !isValid(x, rules))
		.map!(x => x.sort!((a, b) => sortFunc(a, b, rules)))
		.map!(x => x[$ / 2])
		.sum();
	writeln(part2);
}

bool isValid(int[] numbers, bool[int][int] rules) {
	for(int i = 1; i < numbers.length; i++) {
		if (numbers[i] !in rules) {
			continue;
		}
		for(int j = 0; j < i; j++) {
			if (numbers[j] in rules[numbers[i]]) {
				return false;
			}
		}
	}
	return true;
}

bool sortFunc(int a, int b, bool[int][int] rules) => (a in rules) && (b in rules[a]);
