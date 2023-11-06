import std;

class Point
{
	alias opEquals = Object.opEquals;
	int distance, i, j;
	bool visited;
	this(int i, int j)
	{
		this.i = i;
		this.j = j;
	}
	bool opEquals(Point point)
	{
		return i == point.i && j == point.j; 
	}
}
class PriorityQueue
{
	struct Node
	{
		Point value;
		Node *next;
		this(Point a)
		{
			value = a;
		}
	}
	Node *start = null;
	bool isEmpty()
	{
		return start == null;
	}
	void enqueue(Point point)
	{
		point.visited = true;
		auto newNode = new Node(point);
		if(start == null)
			start = newNode;
		else if(point.distance < start.value.distance)
		{
			newNode.next = start;
			start = newNode;
		}
		else
		{
			auto cursor = start;
			while(cursor.next != null && point.distance > cursor.next.value.distance)
				cursor = cursor.next;
			newNode.next = cursor.next;
			cursor.next = newNode;
		}
	}
	Point dequeue()
	{
		assert(!isEmpty());
		auto point = start.value;
		start = start.next;
		return point;
	}
}

void main()
{
	writeln("part1 ", part1);
	writeln("part2 ", part2);
}

int part1()
{
	int [][]matrix;
	File input = File("input.txt", "r");
	while(!input.eof)
		matrix ~= input.readln.chomp.to!(char[]).map!(x => x.to!int - '0').array;
	input.close;
	return dijkstra(matrix);
}
int part2()
{
	int [][]matrix;
	File input = File("input.txt", "r");
	while(!input.eof)
		matrix ~= input.readln.chomp.to!(char[]).map!(x => x.to!int - '0').array;
	input.close;
	matrix.multiply;
	return dijkstra(matrix);
}
int dijkstra(int [][]cost)
{
	Point [][]array;
	for(int i = 0; i < cost.length; i++)
	{
		Point []line;
		for(int j = 0; j < cost[i].length; j++)
			line ~= new Point(i, j);
		array ~= line;
	}
	auto end = array[$ - 1][$ - 1];
	array[0][0].distance = 0;
	auto PQ = new PriorityQueue;
	PQ.enqueue(array[0][0]);
	while(!PQ.isEmpty)
	{
		auto current = PQ.dequeue;
		if(current == end)
			break;
		if(current.i - 1 >= 0)
		{
			auto next = array[current.i - 1][current.j];
			auto next_cost = cost[current.i - 1][current.j];
			next.distance = min(current.distance + next_cost, next.distance);
			if(!next.visited)
				PQ.enqueue(next);
		}
		if(current.i + 1 < array.length)
		{
			auto next = array[current.i + 1][current.j];
			auto next_cost = cost[current.i + 1][current.j];
			next.distance = min(current.distance + next_cost, next.distance);
			if(!next.visited)
				PQ.enqueue(next);
		}
		if(current.j - 1 >= 0)
		{
			auto next = array[current.i][current.j - 1];
			auto next_cost = cost[current.i][current.j - 1];
			next.distance = min(current.distance + next_cost, next.distance);
			if(!next.visited)
				PQ.enqueue(next);
		}
		if(current.j + 1 < array[0].length)
		{
			auto next = array[current.i][current.j + 1];
			auto next_cost = cost[current.i][current.j + 1];
			next.distance = min(current.distance + next_cost, next.distance);
			if(!next.visited)
				PQ.enqueue(next);
		}
	}
	return end.distance;
}
int[][] deep_copy(int [][]matrix)
{
	return matrix.map!(x => x.dup).array;
}
void append_right(ref int[][] matrix, int[][] new_matrix)
{
	foreach(i, line; new_matrix)
		matrix[i] ~= line;
}
void append_down(ref int[][] matrix, int[][] new_matrix)
{
	foreach(line; new_matrix.deep_copy)
		matrix ~= line;	
}
void inc(ref int[][] matrix)
{
	for(int i = 0; i < matrix.length; i++)
		for(int j = 0 ; j < matrix[0].length; j++)
			matrix[i][j] = matrix[i][j] % 9 + 1;
}
void multiply(ref int[][] matrix)
{
	auto copy = matrix.deep_copy;
	foreach(_; 0 .. 4)
	{
		copy.inc;
		matrix.append_right(copy);
	}
	copy = matrix.deep_copy;
	foreach(_; 0 .. 4)
	{
		copy.inc;
		matrix.append_down(copy);
	}
}
