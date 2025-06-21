const expect = @import("std").testing.expect;

// run tests:
// zig test ifelse_pass.zig

test "if statement" {
    const a = false;
    var x: u16 = 0;
    x += if (a) 1 else 2;
    try expect(x == 2);
}

test "if else statement" {
    const a: bool = true;
    var x: u8 = 0;
    if (a) {
        x += 1;
    } else {
        x += 2;
    }
    try expect(x == 1);
}
