class CSPSolver:
    def __init__(self, rows, cols, row_targets, col_targets, initial_grid, unique_constraint=False, step_callback=None):
        self.rows = rows
        self.cols = cols
        self.row_targets = row_targets
        self.col_targets = col_targets
        self.initial_grid = initial_grid
        self.unique_constraint = unique_constraint
        self.step_callback = step_callback
        
        self.current_grid = [[0 for _ in range(cols)] for _ in range(rows)]
        self.row_sums = [0] * rows
        self.col_sums = [0] * cols
        
        self.rem_row_sums = [sum(row) for row in initial_grid]
        self.rem_col_sums = [sum(initial_grid[i][j] for i in range(rows)) for j in range(cols)]

    def solve(self):
        if self._backtrack(0, 0):
            return self.current_grid
        return None

    def _backtrack(self, row, col):
        if self.step_callback:
            self.step_callback(self.current_grid, row, col)

        if row == self.rows:
            return self._is_solved()
            
        next_row = row if col < self.cols - 1 else row + 1
        next_col = col + 1 if col < self.cols - 1 else 0
        
        val = self.initial_grid[row][col]
        self.rem_row_sums[row] -= val
        self.rem_col_sums[col] -= val
        
        # --- Branch 1: Keep Value ---
        can_keep = (self.row_sums[row] + val <= self.row_targets[row]) and \
                   (self.col_sums[col] + val <= self.col_targets[col])
                   
        # Check Uniqueness Constraint
        if can_keep and self.unique_constraint:
            in_row = val in self.current_grid[row]
            in_col = any(self.current_grid[i][col] == val for i in range(self.rows))
            if in_row or in_col:
                can_keep = False

        if can_keep:
            self.current_grid[row][col] = val
            self.row_sums[row] += val
            self.col_sums[col] += val
            
            if self._backtrack(next_row, next_col):
                return True
                
            self.row_sums[row] -= val
            self.col_sums[col] -= val
            self.current_grid[row][col] = 0

        # --- Branch 2: Remove Value ---
        can_remove = (self.row_sums[row] + self.rem_row_sums[row] >= self.row_targets[row]) and \
                     (self.col_sums[col] + self.rem_col_sums[col] >= self.col_targets[col])
                     
        if can_remove:
            if self._backtrack(next_row, next_col):
                return True

        self.rem_row_sums[row] += val
        self.rem_col_sums[col] += val
        
        if self.step_callback:
            self.step_callback(self.current_grid, row, col, backtracking=True)
            
        return False

    def _is_solved(self):
        for i in range(self.rows):
            if self.row_sums[i] != self.row_targets[i]: return False
        for j in range(self.cols):
            if self.col_sums[j] != self.col_targets[j]: return False
        return True