import std;

alias Item = Tuple!(int, "cost", int, "damage", int, "armor");
alias Fighter = Tuple!(int, "health", int, "damage", int, "armor");

void main()
{
    writeln("part1 ", solve(1) == 91);
    writeln("part2 ", solve(2) == 158);
}
int solve(int part)
{
    int function(int, int) func = part == 1 ? &min!(int, int) : &max!(int, int);
    int res = part == 1 ? int.max : 0;
    bool part1 = part == 1;
    Item[][] items = lines("items.txt").get_items();
    Fighter enemy = lines("input.txt").get_enemy();
    foreach(weapon; items[0])
        foreach(armor; items[1])
            foreach(i1; iota(items[2].length))
                foreach(i2; iota(i1 + 1, items[2].length))
                {
                    int damage = weapon.damage + armor.damage + items[2][i1].damage + items[2][i2].damage;
                    int defense = weapon.armor + armor.armor + items[2][i1].armor + items[2][i2].armor;
                    int cost = weapon.cost + armor.cost + items[2][i1].cost + items[2][i2].cost;
                    bool f = fight(Fighter(100, damage, defense), enemy);
                    if(part1 == f)
                        res = func(res, cost);
                }
    return res;
}
bool fight(Fighter me, Fighter enemy)
{
    while(true)
    {
        enemy.health -= max(me.damage - enemy.armor, 1);
        if(enemy.health <= 0)
            return true;    
        me.health -= max(enemy.damage - me.armor, 1);
        if(me.health <= 0)
            return false;
    }
}
Item[][] get_items(string[] lines)
{
    auto lines_splitted = lines.split("").map!(x => x[1 .. $]).array();
    auto nums = lines_splitted.map!(x => x.map!(y => y.split[$ - 3 .. $].to!(int[3])).array()).array();
    auto items = nums.map!(x => x.map!(y => Item(y.tupleof)).array()).array();
    foreach(i; iota(1, 3))
        foreach(_; iota(1, i + 1))
            items[i] = Item(0, 0, 0) ~ items[i];
    return items;
}
Fighter get_enemy(string[] lines)
{
    auto nums = lines.map!(x => x.split[$ - 1]).array().to!(int[3]);
    return Fighter(nums.tupleof);
}
auto lines(string file)
{
    File handle = File(file, "r");
    scope(exit)
        handle.close;
    return handle.byLine.map!(x => x.to!string).array;
}