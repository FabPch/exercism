const std = @import("std");
const ArrayList = std.ArrayList;
const StringHashMap = std.StringHashMap;
const print = std.debug.print;
const separators = [_]u8{ '\n', ' ', '\t', '!', '?', ',', '.', ':', ';' };

fn dupeSlice(slice: []const u8) ![]u8 {
    const copy = try std.heap.page_allocator.alloc(u8, slice.len);
    for (slice, 0..) |char, index| {
        copy[index] = char;
    }
    return copy;
}

pub fn main() !void {
    var map = try countWords(std.heap.page_allocator, "hello you hello");
    defer map.deinit();

    var iterator = map.iterator();
    while (iterator.next()) |entry| {
        print("key: {s}, value: {s}\n", .{ entry.key_ptr, entry.value_ptr });
    }

    var word = ArrayList(u8).init(std.heap.page_allocator);
    try word.appendSlice("hello yala hello");

    const dup = dupeSlice(word.items);
    word.deinit();
    print("type of dup is {}\n", .{@TypeOf(dup)});
    print("dup is {any}\n", .{dup});

    // print("Le mot '{s}' a été utilisé {?} fois", .{ "hello you", map.get("you") });
}

/// Returns the counts of the words in `s`.
/// Caller owns the returned memory.
pub fn countWords(allocator: std.mem.Allocator, line: []const u8) !std.StringHashMap(u32) {
    var map = StringHashMap(u32).init(allocator);
    var cursor: u8 = 0;

    for (line, 0..) |char, index| {
        for (separators) |sep| {
            if (char == sep) {
                if (index - cursor > 0) {
                    print("separator is: {}\n", .{sep});
                    print("word is: {s}\n", .{line[cursor..index]});
                    var count = map.get(line[cursor..index]) orelse 0;
                    try map.put(line[cursor..index], count + 1);
                }
                cursor += @as(u8, @intCast(index)) - cursor + 1; // hel 0 1 2 3 = sep -> 0 + 3 + 1 = 3
                print("cursor: {}\n", .{cursor});
            }
        }
    }

    print("line.len: {}, cursor: {}\n", .{ line.len, cursor });
    if (line.len - cursor > 0) {
        print("word is: {s}\n", .{line[cursor..line.len]});
        var count = map.get(line[cursor..line.len]) orelse 0;
        try map.put(line[cursor..line.len], count + 1);
    }

    return map;
}

/// Returns the counts of the words in `s`.
/// Caller owns the returned memory.
pub fn countWordsBackup(allocator: std.mem.Allocator, s: []const u8) !std.StringHashMap(u32) {
    var word = ArrayList(u8).init(allocator);
    defer word.deinit();
    var map = StringHashMap(u32).init(allocator);
    print("Array type is: {}\n", .{@TypeOf(word)});

    for (s) |char| {
        var is_separator: bool = false;

        for (separators) |sep| {
            if (char == sep) {
                is_separator = true;
                if (word.items.len > 0) {
                    print("separator is: {}\n", .{sep});
                    print("word is: {s}\n", .{word.items});
                    // var count = map.get(word.items) orelse 0;
                    // try map.put(word.items, count + 1);

                    const word_slice = word.items[0..word.items.len];
                    var count = map.get(word_slice) orelse 0;
                    try map.put(word_slice, count + 1);

                    word.clearAndFree();
                    // word.deinit();
                    // word = ArrayList(u8).init(allocator);
                }
            }
        }

        if (!is_separator) {
            try word.append(char);
        }
    }

    if (word.items.len > 0) {
        print("word is: {s}\n", .{word.items});
        print("word type is: {}\n", .{@TypeOf(word.items)});
        const word_slice = word.items[0..word.items.len];
        print("&word_slice type is: {}\n", .{@TypeOf(&word_slice)});
        print("word_slice type is: {}\n", .{@TypeOf(word_slice)});

        // var count = map.get(word.items) orelse 0;
        // try map.put(word.items, count + 1);
        var count = map.get(word_slice) orelse 0;
        try map.put(word_slice, count + 1);
    }

    try map.put("hello", 1);
    var hey = map.get("hello");
    var count = map.count();
    print("Le mot '{s}' a ete utilise {?} fois\n", .{ "hello", hey });
    print("La map a une taille de {?}\n", .{count});

    var iterator = map.iterator();

    while (iterator.next()) |entry| {
        print("key: {s}, value: {?}\n", .{ entry.key_ptr.*, entry.value_ptr.* });
    }

    return map;
}
