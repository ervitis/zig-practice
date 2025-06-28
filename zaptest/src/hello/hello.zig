const std = @import("std");
const zap = @import("zap");

pub fn on_request(r: zap.Request) !void {
    try r.sendBody("<html><body><h1>Hello</h1></body></html>");
}

