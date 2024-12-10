import std;

struct Pos {
	int i, j;
	Pos opBinary(string op: "+")(Pos pos) => Pos(this.i + pos.i, this.j + pos.j);
	Pos opBinary(string op: "-")(Pos pos) => Pos(this.i - pos.i, this.j - pos.j);
}

char[][] lines;
Pos[][char] positions;

void main() {
	lines = File("input.txt").byLineCopy().array().to!(char[][]);
	positions = findPositions();
	writeln(solve(1));
	writeln(solve(2));
}

Pos[][char] findPositions() {
	Pos[][char] res;
	for (int i = 0; i < lines.length; i++) {
		for (int j = 0; j < lines[i].length; j++) {
			char ch = lines[i][j];
			if (ch == '.') continue;
			res[ch] ~= Pos(i, j);
		}
	}
	return res;
}

Pos[] findAntiNodes(Pos[] positions, int part) {
	Pos[] res;
	auto isInBounds = (int x, ulong m) => (0 <= x) && (x < m); 
	auto isPositionValid = (Pos pos) => isInBounds(pos.i, lines.length) && isInBounds(pos.j, lines[0].length);
		
	for (int i = 1; i < positions.length; i++) {
		for (int j = 0; j < i; j++) {
			Pos a = positions[i];
			Pos b = positions[j];
			if (part == 2) res ~= [a, b];
			Pos dp = b - a;
			Pos p1 = b + dp;
			while (isPositionValid(p1)) {
				res ~= p1;
				p1 = p1 + dp;
				if (part == 1) break;
			}
			Pos p2 = a - dp;
			while (isPositionValid(p2)) {
				res ~= p2;
				p2 = p2 - dp;
				if (part == 1) break;
			}
		}
	}
	return res;
}

ulong solve(int part) {
	bool[Pos] hasAntiNode;
	foreach (v; positions) {
		findAntiNodes(v, part)
			.each!(x => hasAntiNode[x] = true);
	}
	return hasAntiNode.length;
}
