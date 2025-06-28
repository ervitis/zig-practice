//! By convention, main.zig is where your main function lives in the case that
//! you are building an executable. If you are making a library, the convention
//! is to delete this file and start with root.zig instead.
const std = @import("std");
const zap = @import("zap");
const hello_module = @import("hello/hello.zig");

pub fn main() !void {
    var listener = zap.HttpListener.init(.{
        .port = 8080,
        .on_request = hello_module.on_request,
        .log = true,
        .max_clients = 500,
    });
    try listener.listen();
    std.debug.print("listening on 127.0.0.1:8080\n", .{});
    zap.start(.{
        .threads = 2,
        .workers = 2,
    });
}
