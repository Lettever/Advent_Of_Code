import std;

alias Player = Tuple!(int, "mana", int, "health");
alias Boss = Tuple!(int, "health", int, "damage");
alias Move = Tuple!(int, "cost", int, "damage", int, "health_regen",
                    int, "turns");
alias State = Tuple!(int, "mana_spent", Player, "player", Boss, "boss",
                     int, "shield_turn", int, "poison_turn", int, "recharge_turn", bool, "is_players_turn");

void main()
{
    writeln("part1 ", solve(1));
    writeln("part2 ", solve(2));
}
auto solve(int part)
{
    auto boss = Boss(lines("input.txt").map!(x => x.split[$ - 1]).array().to!(int[2]).tupleof);
    auto player = Player(500, 50);
    auto magic_missile = Move(53, 4, 0, 0);
    auto drain = Move(73, 2, 2, 0);
    auto shield = Move(113, 0, 0, 6);
    auto poison = Move(173, 0, 0, 6);
    auto recharge = Move(229, 0, 0, 5);
    BinaryHeap!(Array!State, "a > b") pq;
    auto now = State(0, player, boss, 0, 0, 0, true);
    pq.insert(now);
    int i = 0;
    while(!pq.empty())
    {
        i++;
        now = pq.removeAny();
        player = now.player;
        boss = now.boss;
        if(player.health <= 0)
            continue;
        int defense = 0;
        if(now.shield_turn > 0)
        {
            now.shield_turn--;
            defense = 7;
        }
        if(now.poison_turn > 0)
        {
            now.poison_turn--;
            boss.health -= 3;
        }
        if(now.recharge_turn > 0)
        {
            now.recharge_turn--;
            player.mana += 101;
        }
        if(boss.health <= 0)
        {
            writeln(i);
            return now.mana_spent;
        }
        if(now.is_players_turn)
        {
            if(part == 2)
            {
                player.health--;
                if(player.health <= 0)
                    continue;
            }
            if(player.mana < 53)
                continue;
            if(player.mana >= 53)
            {
                //cast missile
                auto player2 = player;
                auto boss2 = boss;
                player2.mana -= magic_missile.cost;
                boss2.health -= magic_missile.damage;
                auto s = State(now.mana_spent + magic_missile.cost, player2, boss2,
                    now.shield_turn, now.poison_turn, now.recharge_turn, false);
                pq.insert(s);
            }
            if(player.mana >= 73)
            {
                //cast drain
                auto player2 = player;
                auto boss2 = boss;
                player2.mana -= drain.cost;
                player2.health += drain.health_regen;
                boss2.health -= drain.damage;
                auto s = State(now.mana_spent + drain.cost, player2, boss2,
                    now.shield_turn, now.poison_turn, now.recharge_turn, false);
                pq.insert(s);
            }
            if(player.mana >= 113 && now.shield_turn == 0)
            {
                //cast shield
                auto player2 = player;
                auto boss2 = boss;
                player2.mana -= shield.cost;
                auto s = State(now.mana_spent + shield.cost, player2, boss2,
                    shield.turns, now.poison_turn, now.recharge_turn, false);
                pq.insert(s);
            }
            if(player.mana >= 173 && now.poison_turn == 0)
            {
                //cast poison
                auto player2 = player;
                auto boss2 = boss;
                player2.mana -= poison.cost;
                auto s = State(now.mana_spent + poison.cost, player2, boss2,
                    now.shield_turn, poison.turns, now.recharge_turn, false);
                pq.insert(s);
            }
            if(player.mana >= 229 && now.recharge_turn == 0)
            {
                //cast recharge
                auto player2 = player;
                auto boss2 = boss;
                player2.mana -= recharge.cost;
                auto s = State(now.mana_spent + recharge.cost, player2, boss2,
                    now.shield_turn, now.poison_turn, recharge.turns, false);
                pq.insert(s);
            }
        }
        else
        {
            //boss atacks
            auto player2 = player;  
            player2.health -= max(boss.damage - defense, 1);
            auto s = State(now.mana_spent, player2, boss,
                now.shield_turn, now.poison_turn, now.recharge_turn, true);
            pq.insert(s);
        }
    }
    return 0;
}
auto lines(string file)
{
    File handle = File(file, "r");
    scope(exit)
        handle.close;
    return handle.byLine.map!(x => x.to!string).array;
}