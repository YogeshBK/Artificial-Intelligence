def print_solution(board):
    for row in board:
        print(" ".join("Q" if col else "." for col in row))
    print()

def is_safe(board, row, col, n):
    for i in range(row):
        if board[i][col]:
            return False
        if col - (row - i) >= 0 and board[i][col - (row - i)]:
            return False
        if col + (row - i) < n and board[i][col + (row - i)]:
            return False
    return True

def solve_n_queens_util(board, row, n, solutions):
    if row == n:
        solutions.append([r[:] for r in board])
        return
    for col in range(n):
        if is_safe(board, row, col, n):
            board[row][col] = 1
            solve_n_queens_util(board, row + 1, n, solutions)
            board[row][col] = 0

def solve_n_queens(n):
    board = [[0]*n for _ in range(n)]
    solutions = []
    solve_n_queens_util(board, 0, n, solutions)
    print(f"Total solutions for {n}-Queens: {len(solutions)}\n")
    for sol in solutions:
        print_solution(sol)

for n in range(4, 9):
    print("="*30)
    print(f"Solving {n}-Queens Problem")
    print("="*30)
    solve_n_queens(n)