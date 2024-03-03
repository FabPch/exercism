pub const earth_year: f64 = 31557600;
const print = @import("std").debug.print;
pub const Planet = enum {
    mercury,
    venus,
    earth,
    mars,
    jupiter,
    saturn,
    uranus,
    neptune,

    pub fn age(self: Planet, seconds: usize) f64 {
        const seconds_f = @as(f64, @floatFromInt(seconds));
        switch (self) {
            .mercury => return seconds_f / (earth_year * 0.2408467),
            .venus => return seconds_f / (earth_year * 0.61519726),
            .earth => return seconds_f / earth_year,
            .mars => return seconds_f / (earth_year * 1.8808158),
            .jupiter => return seconds_f / (earth_year * 11.862615),
            .saturn => return seconds_f / (earth_year * 29.447498),
            .uranus => return seconds_f / (earth_year * 84.016846),
            .neptune => return seconds_f / (earth_year * 164.79132),
        }
    }
};
