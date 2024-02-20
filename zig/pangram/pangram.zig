const std = @import("std");
var alphabet: [26]u8 = undefined;

pub fn isPangram(str: []const u8) bool {
    for (alphabet, 0..) |_, index| {
        alphabet[index] = 0;
    }

    for (str) |char| switch (std.ascii.toUpper(char)) {
        'A'...'Z' => alphabet[std.ascii.toUpper(char) - 65] = 1,
        else => {},
    };

    var result = true;
    for (alphabet) |char| switch (char) {
        0 => result = false,
        else => {},
    };

    return result;
}
