def minimax(depth, node_index, is_maximizing_player, values, branching_factor):
    if depth == 3:
        return values[node_index]

    if is_maximizing_player:
        return max(
            minimax(depth + 1, node_index * branching_factor + i, False, values, branching_factor)
            for i in range(branching_factor)
        )
    else:
        return min(
            minimax(depth + 1, node_index * branching_factor + i, True, values, branching_factor)
            for i in range(branching_factor)
        )

leaf_values = [2, 4, 6, 9, 1, 2, 7, 5]
branching_factor = 2

optimal_value = minimax(0, 0, True, leaf_values, branching_factor)
print("The optimal value is:", optimal_value)