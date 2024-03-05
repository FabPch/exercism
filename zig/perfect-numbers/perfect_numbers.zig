const std = @import("std");
pub const Classification = enum {
    deficient,
    perfect,
    abundant,
};

/// Asserts that `n` is nonzero.
pub fn classify(n: u64) Classification {
    std.debug.assert(n != 0);
    var i: u64 = 1;
    var aliquot_sum: u64 = 0;

    while (i < (n / 2) + 1) : (i += 1) {
        if (n % i == 0) {
            aliquot_sum += i;
        }
    }

    if (aliquot_sum == n) {
        return Classification.perfect;
    } else if (aliquot_sum > n) {
        return Classification.abundant;
    } else {
        return Classification.deficient;
    }
}
