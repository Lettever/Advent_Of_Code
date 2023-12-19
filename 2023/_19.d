import std;

struct MachineParts
{
	long x, m, a, s;
	this(string str)
	{
		str.formattedRead("{x=%d,m=%d,a=%d,s=%d}", x, m, a, s);
	}
}
struct Condition
{
	long num;
	string cmp = "", ch = "", dest;
	this(string str)
	{
		if(str.canFind('>'))
		{
			auto d = str.split(">");
			d = d[0] ~ ">" ~ d[1].split(":");
			ch = d[0];
			cmp = d[1];
			num = d[2].to!long;
			dest = d[3];
		}
		else if(str.canFind('<'))
		{
			auto d = str.split("<");
			d = d[0] ~ "<" ~ d[1].split(":");
			ch = d[0];
			cmp = d[1];
			num = d[2].to!long;
			dest = d[3];
		}
		else
			dest = str;
	}
	bool apply(MachineParts part)
	{
		if(ch == "")
			return true;
		else if(cmp == ">")
			if(ch == "x")
				return part.x > num;
			else if(ch == "m")
				return part.m > num;
			else if(ch == "a")
				return part.a > num;
			else
				return part.s > num;
		else
			if(ch == "x")
				return part.x < num;
			else if(ch == "m")
				return part.m < num;
			else if(ch == "a")
				return part.a < num;
			else
				return part.s < num;
		assert(0);
	}
}
void main()
{
    writeln("part1 ", part1);
    writeln("part2 ", part2);
}

auto part1()
{
    auto input = lines("input.txt").split("");
	auto rules = input[0], idk = input[1];
	Condition[][string] map;
	foreach(rule; rules)
	{
		auto g = rule.findSplit("{");
		map[g[0]] = g[2][0 .. $ - 1].split(",").map!(x => Condition(x)).array;
	}
	long total;
	foreach(a; idk)
	{
		int i;
		auto g = MachineParts(a);
		auto y = map["in"];
		
		while(i < y.length)
		{
			if(y[i].apply(g))
			{
				if(y[i].dest == "A")
				{
					total += g.x + g.m + g.a + g.s;
					break;
				}
				else
					if(y[i].dest == "R")
						break;
				else
				{
					y = map[y[i].dest];
					i = 0;
				}
			}
			else
				i++;
		}
	}
	return total;
}
long part2 ()
{
	Condition[][string] rules;
	foreach(rule; lines("input.txt").split("")[0])
	{
		auto g = rule.findSplit("{");
		rules[g[0]] = g[2][0 .. $ - 1].split(",").map!(x => Condition(x)).array;
	}

	alias Segment = Tuple!(long, q{low}, long, q{high});
	long res = 0;
	
	void recur (string cursor, Segment[string] pos)
	{
		if (cursor == "R")
			return;
		if (cursor == "A")
		{
			long cur = 1;
			foreach (k, v; pos)
				cur *= v.high - v.low + 1;
			res += cur;
			return;
		}

		foreach (rule; rules[cursor])
		{
			if(rule.ch == "")
			{
				recur(rule.dest, pos);
				break;
			}

			auto next = pos.dup;
			if (rule.cmp == "<")
			{
				next[rule.ch].high = min(next[rule.ch].high, rule.num - 1);
				pos[rule.ch].low = max(pos[rule.ch].low, rule.num);
			}
			else if (rule.cmp == ">")
			{
				next[rule.ch].low = max(next[rule.ch].low, rule.num + 1);
				pos[rule.ch].high = min(pos[rule.ch].high, rule.num);
			}
			else
				assert(0);

			if (next[rule.ch].low <= next[rule.ch].high)
				recur(rule.dest, next);
			if (pos[rule.ch].low > pos[rule.ch].high)
				break;
		}
	}

	Segment[string] pos;
	pos["x"] = Segment(1, 4000);
	pos["m"] = Segment(1, 4000);
	pos["a"] = Segment(1, 4000);
	pos["s"] = Segment(1, 4000);
	recur("in", pos);
	return res;
}
auto lines(string file)
{
    File handle = File(file, "r");
    scope(exit)
        handle.close;
    return handle.byLine.map!(x => x.to!string).array;
}