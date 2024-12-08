import std;

void main() {
	ulong[][] input = File("input.txt")
		.byLineCopy()
		.map!(parseLine)
		.array();
	
	ulong part1 = input
		.filter!(x => isOk(x, [&add, &mul]))
		.map!(x => x[0])
		.sum();
	writeln(part1);
	
	ulong part2 = input
		.filter!(x => isOk(x, [&add, &mul, &concat]))
		.map!(x => x[0])
		.sum();
	writeln(part2);
}

ulong[] parseLine(string line) {
	auto a = findSplit(line, ": ");
	return a[0].to!ulong ~ a[2].split().to!(ulong[]);
}

bool isOk(ulong[] numbers, ulong function(ulong, ulong)[] fns) {
	ulong _target = numbers[0];
	ulong[] _nums = numbers[1 .. $];
	bool isOk2(ulong target, ulong[] nums, ulong total) {
		if (total > target) {
			return false;
		}
		if (nums.length == 0) {
			return target == total;
		}
		
		return fns.any!(x => isOk2(target, nums[1 .. $], x(total, nums[0])));
	}
	return isOk2(_target, _nums[1 .. $], _nums[0]);
}

ulong add(ulong a, ulong b) => a + b;
ulong mul(ulong a, ulong b) => a * b;
ulong concat(ulong a, ulong b) => (a.to!string ~ b.to!string).to!ulong;
