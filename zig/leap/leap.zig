pub fn isLeapYear(year: u32) bool {
    const div_by_4: bool = year % 4 == 0 and year % 100 != 0;
    const div_by_400: bool = year % 400 == 0;

    if (div_by_4 or div_by_400) {
        return true;
    } else {
        return false;
    }
}
