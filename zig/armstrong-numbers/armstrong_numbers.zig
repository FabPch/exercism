const std = @import("std");

pub fn isArmstrongNumber(num: u128) bool {
    var num_copy: u128 = num;
    var result: u128 = 0;

    var size: u8 = 0;
    while (num_copy != 0) : (size += 1) {
        num_copy /= 10;
    }

    num_copy = num;
    var i: u8 = 0;
    while (i < size) : (i += 1) {
        result += std.math.pow(u128, num_copy % 10, size);
        num_copy /= 10;
    }

    return result == num;
}
