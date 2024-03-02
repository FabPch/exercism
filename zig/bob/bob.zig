pub fn response(s: []const u8) []const u8 {
    var end_with_qm: bool = false;
    var all_cp_letters: bool = true;
    var at_least_one_cp_letter: bool = false;
    var silence: bool = true;

    for (s) |char| switch (char) {
        ' ', '\n', '\r', '\t' => {},
        'A'...'Z' => {
            at_least_one_cp_letter = true;
            silence = false;
            end_with_qm = false;
        },
        'a'...'z' => {
            all_cp_letters = false;
            silence = false;
            end_with_qm = false;
        },
        '?' => {
            end_with_qm = true;
            silence = false;
        },
        else => {
            silence = false;
            end_with_qm = false;
        },
    };

    if (at_least_one_cp_letter and all_cp_letters and end_with_qm) {
        return "Calm down, I know what I'm doing!";
    } else if (silence) {
        return "Fine. Be that way!";
    } else if (end_with_qm) {
        return "Sure.";
    } else if (at_least_one_cp_letter and all_cp_letters) {
        return "Whoa, chill out!";
    } else {
        return "Whatever.";
    }
}
