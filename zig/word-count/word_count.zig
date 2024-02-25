const std = @import("std");
const StringHashMap = std.StringHashMap;
const print = std.debug.print;
// const apostrophe: u8 = '\'';

fn dupWordInLowerCaseWithoutQuotes(allocator: std.mem.Allocator, line: []const u8) ![]u8 {
    var start: usize = 0;
    var end: usize = line.len;

    if (line[0] == '\'') {
        start += 1;
    }
    if (line[line.len - 1] == '\'') {
        end -= 1;
    }

    var lower_line: []u8 = try allocator.alloc(u8, end - start);
    for (line[start..end], 0..) |char, index| {
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
        // If index is not at the end, we retrieve on word when we meet a separator:
        //   (!std.ascii.isAlphanumeric(char) and char != '\'')
        if (!std.ascii.isAlphanumeric(char) and char != '\'') {
            if (index - cursor > 0) {
                const word = try dupWordInLowerCaseWithoutQuotes(allocator, line[cursor..index]);
                var entry = try map.getOrPut(word);

                if (entry.found_existing) {
                    entry.value_ptr.* += 1;
                    allocator.free(word);
                } else {
                    entry.value_ptr.* = 1;
                }
            }

            cursor += @as(u8, @intCast(index)) - cursor + 1; // increment cursor to +1 or word.len
        }
    }

    // If index is at the last position, we retrieve the last word, except if this just an apostrophe:
    //   (line.len - cursor > 0 and (line.len - cursor != 1 or line[line.len - 1] != '\''))
    if (line.len - cursor > 0 and (line.len - cursor != 1 or line[line.len - 1] != '\'')) {
        var word = try dupWordInLowerCaseWithoutQuotes(allocator, line[cursor..line.len]);
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
