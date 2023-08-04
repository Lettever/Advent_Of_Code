#include "header.h"
#define MAX_ITEMS 36
#define lcm 9699690
struct monkey
{
	u64 items[MAX_ITEMS];
	int size;
	int current_item;
	int other_monkeys[2];
	int div;
	char op;
	int number;
};
monkey create_monkey(int number)
{
	monkey result = malloc(sizeof(*result));
	result->size = 0;
	result->current_item = 0;
	switch (number)
	{
	case 0:
		insert(result, 53);
		insert(result, 89);
		insert(result, 62);
		insert(result, 57);
		insert(result, 74);
		insert(result, 51);
		insert(result, 83);
		insert(result, 97);
		result->op = '*';
		result->number = 3;
		result->div = 13;
		result->other_monkeys[true] = 1;
		result->other_monkeys[false] = 5;
		break;
	case 1:
		insert(result, 85);
		insert(result, 94);
		insert(result, 97);
		insert(result, 92);
		insert(result, 56);
		result->op = '+';
		result->number = 2;
		result->div = 19;
		result->other_monkeys[true] = 5;
		result->other_monkeys[false] = 2;
		break;
    case 2:
    	insert(result, 86);
    	insert(result, 82);
    	insert(result, 82);
    	result->op = '+';
    	result->number = 1;
    	result->div = 11;
		result->other_monkeys[true] = 3;
		result->other_monkeys[false] = 4;
		break;
	case 3:
		insert(result, 94);
		insert(result, 68);
		result->op = '+';
		result->number = 5;
		result->div = 17;
		result->other_monkeys[true] = 7;
		result->other_monkeys[false] = 6;
		break;
	case 4:
		insert(result, 83);
		insert(result, 62);
		insert(result, 74);
		insert(result, 58);
		insert(result, 96);
		insert(result, 68);
		insert(result, 85);
		result->op = '+';
    	result->number = 4;
    	result->div = 3;
		result->other_monkeys[true] = 3;
		result->other_monkeys[false] = 6;
		break;
	case 5:
		insert(result, 50);
		insert(result, 68);
		insert(result, 95);
		insert(result, 82);
		result->op = '+';
		result->number = 8;
		result->div = 7;
		result->other_monkeys[true] = 2;
		result->other_monkeys[false] = 4;
		break;
	case 6:
		insert(result, 75);
		result->op = '*';
		result->number = 7;
		result->div = 5;
		result->other_monkeys[true] = 7;
		result->other_monkeys[false] = 0;
		break;
	case 7:
		insert(result, 92);
		insert(result, 52);
		insert(result, 85);
		insert(result, 89);
		insert(result, 68);
		insert(result, 82);
		result->op = '^';
		result->number = 2;
		result->div = 2;
		result->other_monkeys[true] = 0;
		result->other_monkeys[false] = 1;
		break;
    }
    return result;
}
void insert(monkey monkey, u64 value)
{
	monkey->items[monkey->size++] = value;
}
u64 remove_item(monkey monkey)
{
	return monkey->items[monkey->current_item++];
}
void update_item(monkey monkey)
{
	if(monkey->op == '+')
		monkey->items[monkey->current_item] += monkey->number;
	else if(monkey->op == '*')
		monkey->items[monkey->current_item] *= monkey->number;
	else
		monkey->items[monkey->current_item] *= monkey->items[monkey->current_item];
	monkey->items[monkey->current_item] %= lcm;
}
void throw_items(int current_monkey, monkey *monkey_array, int *array)
{
	while(monkey_array[current_monkey]->current_item != monkey_array[current_monkey]->size)
	{
		update_item(monkey_array[current_monkey]);
		u64 item = remove_item(monkey_array[current_monkey]);
		int next_monkey = monkey_array[current_monkey]->other_monkeys[item % monkey_array[current_monkey]->div == 0];
		insert(monkey_array[next_monkey], item);
		array[current_monkey]++;
	}
	monkey_array[current_monkey]->size = 0;
	monkey_array[current_monkey]->current_item = 0;
}
