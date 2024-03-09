/// Writes a reversed copy of `s` to `buffer`.
pub fn reverse(buffer: []u8, s: []const u8) []u8 {
    var i: u8 = 0;
    while (i < s.len) : (i += 1) {
        buffer[i] = s[s.len - 1 - i];
    }
    return buffer;
}
