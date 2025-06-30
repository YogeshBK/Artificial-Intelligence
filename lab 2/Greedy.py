import heapq

graph = {
    'S': [('A', 6), ('D', 3)],
    'A': [('B', 5)], 
    'B': [('C', 4), ('E', 5)],
    'C': [],
    'D': [('E', 5)],
    'E': [('F', 4)],
    'F': [('G', 3)],
    'G': []
}

h = {
    'S': 12, 'A': 8, 'B': 7, 'C': 5,
    'D': 9, 'E': 4, 'F': 2, 'G': 0
}

def greedy_best_first(start, goal):
    visited = set()
    pq = [(h[start], start)]
    path = {}
    while pq:
        _, current = heapq.heappop(pq)
        if current in visited:
            continue
        visited.add(current)
        print(current, end=' ')
        if current == goal:
            break
        for neighbor, _ in graph[current]:
            if neighbor not in visited:
                heapq.heappush(pq, (h[neighbor], neighbor))
                path[neighbor] = current

def a_star(start, goal):
    open_set = [(h[start], 0, start)]
    came_from = {}
    cost_so_far = {start: 0}
    while open_set:
        _, cost, current = heapq.heappop(open_set)
        if current == goal:
            break
        for neighbor, edge_cost in graph[current]:
            new_cost = cost + edge_cost
            if neighbor not in cost_so_far or new_cost < cost_so_far[neighbor]:
                cost_so_far[neighbor] = new_cost
                priority = new_cost + h[neighbor]
                heapq.heappush(open_set, (priority, new_cost, neighbor))
                came_from[neighbor] = current
    path = []
    node = goal
    while node != start:
        path.append(node)
        node = came_from.get(node, start)
    path.append(start)
    print(" -> ".join(reversed(path)))

print("Greedy Best-First Search Path:")
greedy_best_first('S', 'G')
print("\n\nA* Search Path:")
a_star('S', 'G')