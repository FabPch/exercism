pub fn twoFer(buffer: []u8, name: ?[]const u8) anyerror![]u8 {
    const start = "One for ";
    const end = ", one for me.";
    const middle = name orelse "you";

    var i: u8 = 0;
    while (i < middle.len + start.len + end.len) : (i += 1) {
        if (i < start.len) {
            buffer[i] = start[i];
        } else if (i < start.len + middle.len) {
            buffer[i] = middle[i - start.len];
        } else {
            buffer[i] = end[i - middle.len - start.len];
        }
    }

    return buffer[0..i];
}
