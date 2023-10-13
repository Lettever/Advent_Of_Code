import std.stdio;
import std.string;
import std.algorithm;
import std.array;
import std.conv;

class Basin
{
	int value, i, j;
	bool visited;
	this(int value, int i, int j)
	{	
		this.value = value;
		this.i = i;
		this.j = j;
		if(value == 9)
			this.visited = true;
	}
}
class Queue
{
	Basin []queue;
	void enqueue(ref Basin basin)
	{
		this.queue ~= basin;
		basin.visited = true;
	}
	Basin dequeue()
	{
		Basin result = queue[0];
		queue = queue[1 .. $];
		return result;
	}
	ulong length() => queue.length;
}
void main()
{
	writeln("part1 ", part1);
	writeln("part2 ", part2);
}
int part1()
{
	File input = File("file.txt", "r");
	int [][]matrix;
	while(!input.eof)
		matrix ~= input.readln.chomp.split("").to!(int[]);
	input.close;
	int low_points_sum;
	for(int i = 0; i < matrix.length; i++)
		for(int j = 0; j < matrix[i].length; j++)
		{
			int key = matrix[i][j];
			if(i >= 1 && key >= matrix[i - 1][j])
				continue;
			if(i < matrix.length - 1 && key >= matrix[i + 1][j])
				continue;
			if(j >= 1 && key >= matrix[i][j - 1])
				continue;
			if(j < matrix[i].length - 1 && key >= matrix[i][j + 1])
				continue;
			low_points_sum += 1 + key;
		}
	return low_points_sum;
}
int part2()
{
	File input = File("file.txt", "r");
	Basin [][]matrix;
	int i, j;
	while(!input.eof)
	{
		matrix ~= input.readln.chomp.split("").to!(int[]).map!(e => new Basin(e, i, j++)).array;
		j = 0;
		i++;
	}
	input.close;
	int []sizes;
	for(i = 0; i < matrix.length; i++)
		for(j = 0; j < matrix[i].length; j++)
		{
			Basin start = matrix[i][j];
			if(!start.visited)
				sizes ~= matrix.bfs(start);
		}
	sort(sizes);
	return sizes[$ - 1] * sizes[$ - 2] * sizes[$ - 3];
}
int bfs(Basin [][]matrix, Basin start)
{
	int size;
	Queue queue = new Queue;
	queue.enqueue(start);
	Basin next;
	while(queue.length != 0)
	{
		size++;
		start = queue.dequeue;
		if(start.i >= 1)
		{
			Basin next = matrix[start.i - 1][start.j];
			if(!next.visited)
				queue.enqueue(next);
		}
		if(start.i < matrix.length - 1)
		{
			Basin next = matrix[start.i + 1][start.j];
			if(!next.visited)
				queue.enqueue(next);
		}
		if(start.j >= 1)
		{
			Basin next = matrix[start.i][start.j - 1];
			if(!next.visited)
				queue.enqueue(next);
		}
		if(start.j < matrix[start.i].length - 1)
		{
			Basin next = matrix[start.i][start.j + 1];
			if(!next.visited)
				queue.enqueue(next);
		}
	}
	return size;
}
