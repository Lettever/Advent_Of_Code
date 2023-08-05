#include "header.h"

struct queue
{
	int size;
	node start, end;
};
node create_node(char value, int i, int j)
{
	node result = malloc(sizeof(*result));
	result->value = value;
	result->i = i;
	result->j = j;
	result->steps_from_start = -1;
	result->visited = 0;
	return result;
}
graph create_graph(char* file_name)
{
	FILE* fp = fopen(file_name, "r");
	graph result = malloc(sizeof(*result));
	char cursor;
	int i = 0, j = 0;
	fseek(fp, 0, SEEK_END);
	result->max_nodes = ftell(fp);
	fseek(fp, 0, SEEK_SET);
	while(!feof(fp))
	{
		cursor = getc(fp);
		if(cursor == '\n')
		{
			i++;
			j = 0;
		}
		else
		{
			if(cursor == 'S')
			{
				result->start_i = i;
				result->start_j = j;
				cursor = 'a';
			}
			else if(cursor == 'E')
			{
				result->end_i = i;
				result->end_j = j;
				cursor = 'z';
			}
			result->graph[i][j] = create_node(cursor, i, j);
			j++;
		}
	}
	fclose(fp);
	return result;
}
void print_graph(graph graph)
{
	for(int i = 0; i < MAX_LINES; i++)
	{
		for(int j = 0; j < MAX_COLLUMNS; j++)
			printf("%c", graph->graph[i][j]->value);
		printf("\n");
	}
}
queue create_queue()
{
	queue result = malloc(sizeof(*result));
	result->size = 0;
	result->start = NULL;
	result->end = NULL;
	return result;
}
void enqueue(queue queue, node new_node)
{
	if(queue->size == 0)
	{
		queue->start = new_node;
		queue->end = new_node;
		queue->size++;
		return;
	}
	queue->end->next = new_node;
	queue->end = new_node;
	queue->size++;
}
node dequeue(queue queue)
{
	if(queue->size == 0)
	{
		printf("Queue is empty\n");
		return NULL;
	}
	node old_node = queue->start;
	queue->start = queue->start->next;
	queue->size--;
	return old_node;
}

void free_graph(graph graph)
{
	for(int i = 0; i < MAX_LINES; i++)
		for(int j = 0; j < MAX_COLLUMNS; j++)
			free(graph->graph[i][j]);
	free(graph->graph);
	free(graph);
}

int bfs(graph graph, int start_i, int start_j)
{
	int max_nodes = graph->max_nodes;
	int i = start_i;
	int j = start_j;
	int source = 0, destination = 1;
	queue queues[2];
	for(int k = 0; k < 2; k++)
		queues[k] = create_queue();
	node cursor = graph->graph[i][j];
	node next_node;
	enqueue(queues[source], cursor);
	cursor->steps_from_start = 0;
	cursor->visited = 1;
	
	while(max_nodes--)
	{
		while(queues[source]->size != 0)
		{
			cursor = dequeue(queues[source]);
			i = cursor->i;
			j = cursor->j;
			if((i == graph->end_i) && (j == graph->end_j))
				goto END;
			
			if(i - 1 >= 0)
			{
				next_node = graph->graph[i - 1][j];
				if(next_node->visited == 0)
					if(next_node->value - cursor->value <= 1)
					{
						next_node->visited = 1;
						next_node->steps_from_start = cursor->steps_from_start + 1;
						enqueue(queues[destination], next_node);
					}
			}
			
			if(i + 1 < MAX_LINES)
			{
				next_node = graph->graph[i + 1][j];
				if(next_node->visited == 0)
					if(next_node->value - cursor->value <= 1)
					{
						next_node->visited = 1;
						next_node->steps_from_start = cursor->steps_from_start + 1;
						enqueue(queues[destination], next_node);
					}
			}
						
			if(j + 1 < MAX_COLLUMNS)
			{
				next_node = graph->graph[i][j + 1];
				if(next_node->visited == 0)
					if(next_node->value - cursor->value <= 1)
					{
						next_node->visited = 1;
						next_node->steps_from_start = cursor->steps_from_start + 1;
						enqueue(queues[destination], next_node);
					}
			}
			
			if(j - 1 >= 0)
			{
				next_node = graph->graph[i][j - 1];
				if(next_node->visited == 0)
					if(next_node->value - cursor->value <= 1)
					{
						next_node->visited = 1;
						next_node->steps_from_start = cursor->steps_from_start + 1;
						enqueue(queues[destination], next_node);
					}
			}
		}
		if(queues[destination]->size == 0)	//if this queue is empty it means there are no neighbours not visited
			return ERROR;
		source = 1 - source;
		destination = 1 - destination;
	}
	END:
	for(int k = 0; k < 2; k++)
		free(queues[k]);
	int total_steps = cursor->steps_from_start;
	for(int i = 0; i < MAX_LINES; i++)
		for(int j = 0; j < MAX_COLLUMNS; j++)
		{
			graph->graph[i][j]->visited = 0;
			graph->graph[i][j]->steps_from_start = -1;
		}
	if(cursor->value == 'z')
		return total_steps;
	return INT_MAX;
}

void print_node(node node)
{
	printf("%c :: {%i, %i} :: %i\n", node->value, node->i, node->j, node->steps_from_start);
}
