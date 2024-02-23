pub const ComputationError = error{IllegalArgument};

pub fn steps(number: usize) anyerror!usize {
    var result: usize = number;
    var cpt: usize = 0;

    if (number == 0) {
        return ComputationError.IllegalArgument;
    }

    while (result != 1) : (cpt += 1) switch (result % 2) {
        0 => result = result / 2,
        else => result = (result * 3) + 1,
    };
    return cpt;
}
