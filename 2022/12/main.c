#include "header.h"
int main()
{
	int a = 0;
	graph main_graph = create_graph("file.txt");
	int steps = bfs(main_graph, main_graph->start_i, main_graph->start_j);
	printf("part1 :: %i\n", steps);
	int min = INT_MAX;
	for(int i = 0; i < MAX_LINES; i++)
		for(int j = 0; j < MAX_COLLUMNS; j++)
			if(main_graph->graph[i][j]->value == 'a')
			{
				int temp = bfs(main_graph, i, j);
				if(temp == INT_MAX)
					a++;
				else if(temp < min)
					min = temp;
			}
				
	printf("part2 :: %i", min);
	free(main_graph);
}
