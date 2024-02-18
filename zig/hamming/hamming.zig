pub const DnaError = error{ UnequalDnaStrands, EmptyDnaStrands };

pub fn compute(first: []const u8, second: []const u8) DnaError!usize {
    if (first.len == 0 or second.len == 0) {
        return DnaError.EmptyDnaStrands;
    } else if (first.len != second.len) {
        return DnaError.UnequalDnaStrands;
    }

    var result: usize = 0;
    for (first, 0..) |char, index| {
        if (char != second[index]) {
            result += 1;
        }
    }

    return result;
}
