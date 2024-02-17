const std = @import("std");
const no_count_words = [2]u8{ ' ', '-' };

pub fn isIsogram(str: []const u8) bool {
    var map = std.AutoHashMap(u8, u8).init(std.heap.page_allocator);
    defer map.deinit();

    for (str) |char| {
        var should_count = true;

        for (no_count_words) |word| {
            if (word == char) {
                should_count = false;
            }
        }

        if (should_count) {
            var upper_char: u8 = std.ascii.toUpper(char);
            var count = map.get(upper_char) orelse 0;
            if (count == 1) {
                return false;
            } else {
                map.put(upper_char, 1) catch {};
            }
        }
    }

    return true;
}
