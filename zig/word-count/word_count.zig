const std = @import("std");
const StringHashMap = std.StringHashMap;
const print = std.debug.print;

fn dupeWordInLowerCase(allocator: std.mem.Allocator, line: []const u8) ![]u8 {
    var lower_line: []u8 = try allocator.alloc(u8, line.len);

    for (line, 0..) |char, index| {
        lower_line[index] = std.ascii.toLower(char);
    }

    return lower_line;
}

/// Returns the counts of the words in `s`.
/// Caller owns the returned memory.
pub fn countWords(allocator: std.mem.Allocator, line: []const u8) !std.StringHashMap(u32) {
    var map = StringHashMap(u32).init(allocator);
    var cursor: u8 = 0;

    for (line, 0..) |char, index| {
        //(char != '\'' or index == 0)
        if (!std.ascii.isAlphanumeric(char)) {
            if (index - cursor > 0) {
                print("separator is: {}\n", .{char});
                print("word is: {s}\n", .{line[cursor..index]});

                var word = try dupeWordInLowerCase(allocator, line[cursor..index]);
                var entry = try map.getOrPut(word);
                if (entry.found_existing) {
                    entry.value_ptr.* += 1;
                    allocator.free(word);
                } else {
                    entry.value_ptr.* = 1;
                }
            }

            cursor += @as(u8, @intCast(index)) - cursor + 1; // hel 0 1 2 3 = sep -> 0 + 3 + 1 = 3
            print("cursor: {}\n", .{cursor});
        }
    }

    print("line.len: {}, cursor: {}\n", .{ line.len, cursor });

    if (line.len - cursor > 0) {
        print("word is: {s}\n", .{line[cursor..line.len]});

        var word = try dupeWordInLowerCase(allocator, line[cursor..line.len]);
        var entry = try map.getOrPut(word);
        if (entry.found_existing) {
            entry.value_ptr.* += 1;
            allocator.free(word);
        } else {
            entry.value_ptr.* = 1;
        }
    }

    return map;
}
