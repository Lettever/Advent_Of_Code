import std;

class Folder
{
	Folder parent = null;
	long size;
	Folder[] folders;
	void append(Folder f)
	{
		f.parent = this;
		folders ~= f;
	}
	Folder prev()
	{
		size += folders.fold!((acc, x) => acc + x.size)(0L);
		return parent;
	}
}
void main()
{
	//creates the tree
	//we ignore the first command because otherwise we would create the root twice
	auto cursor = new Folder();
	foreach(line; lines("input.txt")[1 .. $])
		if(line == "$ ls" || line[0] == 'd')
			continue;
		else if(line == "$ cd ..")
			cursor = cursor.prev();
		else if(line[0] == '$')
		{
			cursor.append(new Folder());
			cursor = cursor.folders[$ - 1];
		}
		else
			cursor.size += line.split(" ")[0].to!long;
	//sets the cursor to be the root
	while(cursor.parent !is null)
		cursor = cursor.prev;
	cursor.size += cursor.folders.fold!((acc, x) => acc + x.size)(0L);
	auto sizes = sizes(cursor);
	writeln("part1 ", sizes.filter!(x => x <= 100000).sum);
	writeln("part2 ", sizes.filter!(x => x > (cursor.size - 40000000)).minElement);
}
long[] sizes(Folder cursor) => cursor.folders.fold!((acc, x) => acc ~ sizes(x))([cursor.size]);
auto lines(string file)
{
	File handle = File(file, "r");
	scope(exit)
		handle.close;
	return handle.byLine.map!(x => x.to!string).array;
}