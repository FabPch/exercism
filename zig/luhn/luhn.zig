pub fn isValid(s: []const u8) bool {
    var result: u32 = 0;
    var cpt: u8 = 0;
    var has_only_digit = true;

    for (s, 0..) |_, index| {
        switch (s[s.len - 1 - index]) {
            '0'...'9' => {
                var number: u8 = s[s.len - 1 - index] - '0';
                if (cpt % 2 == 0) {
                    result += number;
                } else if (number > 4) {
                    result += (number * 2) - 9;
                } else {
                    result += number * 2;
                }
                cpt += 1;
            },
            ' ' => {},
            else => has_only_digit = false,
        }
    }

    return has_only_digit and cpt > 1 and result % 10 == 0;
}
