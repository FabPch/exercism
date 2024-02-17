const std = @import("std");
pub fn isValidIsbn10(s: []const u8) bool {
    var count: u8 = 0;
    var result: u32 = 0;

    for (s) |char| {
        if (count > 9) {
            return false;
        }

        switch (char) {
            '0'...'9' => {
                var number = char - '0';
                result += (10 - count) * number;
                count += 1;
            },
            'X', 'x' => {
                if (count == 9) {
                    result += 10;
                    count += 1;
                } else {
                    count = 20;
                }
            },
            '-' => {},
            else => count = 20,
        }
    }

    return count == 10 and result % 11 == 0;
}
