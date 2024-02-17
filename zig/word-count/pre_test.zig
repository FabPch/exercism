const std = @import("std");
const print = std.debug.print;
const ArrayList = std.ArrayList;
const StringHashMap = std.StringHashMap;
const test_allocator = std.testing.allocator;

test "string hash map" {
    var map = StringHashMap(u16).init(test_allocator);
    defer map.deinit();

    try map.put("hello", 1);

    var count = map.get("hello") orelse 0;
    print("Type of count if found: {?}\n", .{count});

    count = map.get("hey") orelse 0;
    print("Type of count if not found: {?}\n", .{count});
}

test "iterate on string" {
    const string = "hello, how are you ? you";
    const separators = [_]u8{ '\n', ' ', '\t', '!', '?', ',', '.', ':', ';' };

    var word = ArrayList(u8).init(test_allocator);
    defer word.deinit();

    var map = StringHashMap(u32).init(test_allocator);
    defer map.deinit();

    for (string) |char| {
        var is_separator: bool = false;

        for (separators) |sep| {
            if (char == sep) {
                is_separator = true;
                if (word.items.len > 0) {
                    print("word is: {s}\n", .{word.items});
                    var count = map.get(word.items) orelse 0;
                    try map.put(word.items, count + @as(u32, @intCast(word.items.len)));

                    word.deinit();
                    word = ArrayList(u8).init(test_allocator);
                }
            }
        }

        if (!is_separator) {
            try word.append(char);
        }
    }

    if (word.items.len > 0) {
        print("word is: {s}\n", .{word.items});
        var count = map.get(word.items) orelse 0;
        try map.put(word.items, count + @as(u32, @intCast(word.items.len)));
    }

    var iter = map.iterator();
    while (iter.next()) |item| {
        print("Key is: {s}, value is: {s}\n", .{ item.key_ptr, item.value_ptr });
    }

    print("ArrayList is: {s}\n", .{word.items});
}
