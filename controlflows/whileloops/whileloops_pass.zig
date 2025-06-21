const expect = @import("std").testing.expect;
const std = @import("std");

test "while loops" {
    var sum: u8 = 0;
    var i: u8 = 0;
    while (i < 4) : (i += 1) {
        if (i == 2) continue;
        sum += 1;
    }

    // print debug
    std.debug.print("sum: {d}\n", .{sum});
    try expect(sum == 3);
}
