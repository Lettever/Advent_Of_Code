#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <limits.h>

#ifndef HEADER_H
#define HEADER_H

#define ERROR INT_MAX
#define MAX_LINES 41
#define MAX_COLLUMNS 144

typedef struct node *node;
typedef struct graph *graph;
typedef struct queue *queue;

struct node
{
	char value;
	int visited, i, j, steps_from_start;
	node next;
};
struct graph
{
	node graph[MAX_LINES][MAX_COLLUMNS];
	int idk[2];
	int start_i, start_j;
	int end_i, end_j;
	int max_nodes;
};

node create_node(char, int, int);
graph create_graph(char*);
int bfs(graph, int, int);

void print_graph(graph);

queue create_queue();
void enqueue(queue, node);
node dequeue(queue);
void print_node(node);
#endif
