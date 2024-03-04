const std = @import("std");
pub const QueenError = error{
    InitializationFailure,
};

pub const Queen = struct {
    row: i8,
    col: i8,

    pub fn init(row: i8, col: i8) QueenError!Queen {
        if (row < 0 or row > 7 or col < 0 or col > 7) return QueenError.InitializationFailure;
        return Queen{
            .row = row,
            .col = col,
        };
    }

    pub fn canAttack(self: Queen, other: Queen) QueenError!bool {
        const share_line: bool = self.row == other.row or self.col == other.col;
        const share_diag: bool = std.math.absCast(self.row - other.row) == std.math.absCast(self.col - other.col);

        return share_line or share_diag;
    }
};
