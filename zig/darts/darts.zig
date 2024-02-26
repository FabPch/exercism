const std = @import("std");
pub const Coordinate = struct {
    // This struct, as well as its fields and methods, needs to be implemented.
    x: f32,
    y: f32,

    pub fn init(x_coord: f32, y_coord: f32) Coordinate {
        return Coordinate{
            .x = x_coord,
            .y = y_coord,
        };
    }

    pub fn score(self: Coordinate) usize {
        const hyp_len = std.math.sqrt(self.x * self.x + self.y * self.y);

        if (hyp_len <= 1) {
            return 10;
        } else if (hyp_len <= 5) {
            return 5;
        } else if (hyp_len <= 10) {
            return 1;
        }

        return 0;
    }
};
