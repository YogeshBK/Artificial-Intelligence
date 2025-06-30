from collections import deque

graph = {
    1: [2, 7, 8],
    2: [3, 6],
    3: [4, 5],
    8: [9, 12],
    9: [10],
    12: [11]
}

def dfs(start):
    visited = set()
    stack = [start]
    while stack:
        node = stack.pop()
        if node not in visited:
            print(node, end=' ')
            visited.add(node)
            stack.extend(reversed(graph.get(node, [])))

def bfs(start):
    visited = set()
    queue = deque([start])
    while queue:
        node = queue.popleft()
        if node not in visited:
            print(node, end=' ')
            visited.add(node)
            queue.extend(graph.get(node, []))

print("DFS Traversal:")
dfs(1)

print("\nBFS Traversal:")
bfs(1)