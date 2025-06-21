const expect = @import("std").testing.expect;
const std = @import("std");

test "for loops" {
    const string = [_]u8{'a', 'b', 'c'};

    for (string, 0..) |c, i| {
        _ = c;
        _ = i;
    }

    for (string) |c| {
        _ = c;
    }

    for (string, 0..) |_, i| {
        _ = i;
    }

    for (string, 0..) |c, i| {
        std.debug.print("i {} - c {}\n", .{i,c});
    }
}
