const std = @import("std");
const test_allocator = std.testing.allocator;

test "duplicate with lower" {
    const line = "hello You";
    var lower_slice: []u8 = try test_allocator.alloc(u8, line.len);
    defer test_allocator.free(lower_slice);

    for (line, 0..) |char, index| {
        lower_slice[index] = std.ascii.toLower(char);
    }
    std.debug.print("copy: {s}\n", .{lower_slice});
}

test "duplicate with function" {
    const line = "Hallo, wie ghet's ?";
    var lower_line = try dupeLineInLowerCase(test_allocator, line);
    defer test_allocator.free(lower_line);

    std.debug.print("copy with function: {s}", .{lower_line});
}

fn dupeLineInLowerCase(allocator: std.mem.Allocator, line: []const u8) ![]u8 {
    var lower_line: []u8 = try allocator.alloc(u8, line.len);

    for (line, 0..) |char, index| {
        lower_line[index] = std.ascii.toLower(char);
    }
    return lower_line;
}
