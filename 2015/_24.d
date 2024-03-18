import std;

void main()
{
    writeln("part1 ", solve(1) == 10439961859);
    writeln("part2 ", solve(2) == 72050269);
}
auto solve(int part)
{
    auto nums = lines("input.txt").to!(int[]);
    int target = nums.sum / (part + 2);
    long helper(long prod, long sum, int i)
    {
        if(prod < 0)
            return long.max;
        if(sum > target)
            return long.max;
        if(sum == target)
            return prod;
        return iota(i + 1, nums.length).fold!((acc, x) => min(acc, helper(prod * nums[x], sum + nums[x], x)))(long.max);
    }
    return iota(nums.length).fold!((acc, x) => min(acc, helper(nums[x], nums[x], x)))(long.max);
}
long prod(int[] arr) => arr.fold!"a * b"(1L);
auto lines(string file)
{
    File handle = File(file, "r");
    scope(exit)
        handle.close;
    return handle.byLine.map!(x => x.to!string).array;
}