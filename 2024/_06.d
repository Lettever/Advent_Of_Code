import std;


void main() {
	writeln(part1());
	writeln(part2());
}

ulong part1() {
	string[] lines = File("input.txt").byLineCopy().array();
	bool[int][int] visited;
	int i, j;
	int[][] directions = [
		[-1, 0],
		[0, 1],
		[1, 0],
		[0, -1]
	];
	int iDir = 0;
	int[] dir = directions[iDir];
	AliasSeq!(i, j) = findStart(lines);
	while(inMat(i, j, lines)) {
		visited[i][j] = true;
		int nextI = i + dir[0];
		int nextJ = j + dir[1];
		
		if (!inMat(nextI, nextJ, lines)) {
			break;
		}
		
		if (lines[nextI][nextJ] == '#') {
			iDir = (iDir + 1) % 4;
			dir = directions[iDir];
		} else {
			i = nextI;
			j = nextJ;
		}
	}
	return visited
		.values()
		.map!(x => x.keys().length)
		.sum();
}

bool inMat(int i, int j, string[] lines) {
	return i >= 0 && i < lines.length && j >= 0 && j < lines[i].length;
}
Tuple!(int, int) findStart(string[] lines) {
	for (int i = 0; i < lines.length; i++) {
		for (int j = 0; j < lines[i].length; j++) {
			if (lines[i][j] == '^') {
				return tuple(i, j);
			}
		}
	}
	assert(0);
}
bool isInInfiniteLoop(string[] lines) {
	bool[int][int][int] visited;
	int i, j;
	int[][] directions = [
		[-1, 0],
		[0, 1],
		[1, 0],
		[0, -1]
	];
	int iDir = 0;
	int[] dir = directions[iDir];
	AliasSeq!(i, j) = findStart(lines);
	while(inMat(i, j, lines)) {
		if ((i in visited) && (j in visited[i]) && (iDir in visited[i][j])) {
			return true;
		}
		visited[i][j][iDir] = true;
		int nextI = i + dir[0];
		int nextJ = j + dir[1];
		
		if (!inMat(nextI, nextJ, lines)) {
			break;
		}
		
		if (lines[nextI][nextJ] == '#') {
			iDir = (iDir + 1) % 4;
			dir = directions[iDir];
		} else {
			i = nextI;
			j = nextJ;
		}
	}
	return false;
}

int part2() {
	char[][] lines = File("input.txt").byLineCopy().array().to!(char[][]);
	int res = 0;
	for(int i = 0; i < lines.length; i++) {
		for(int j = 0; j < lines[i].length; j++) {
			if (lines[i][j] == '^' || lines[i][j] == '#') {
				continue;
			}
			lines[i][j] = '#';
			res += isInInfiniteLoop(lines.to!(string[]));
			lines[i][j] = '.';
		}
	}
	return res;
}
