const std = @import("std");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    var arena = std.heap.ArenaAllocator.init(gpa.allocator());
    _ = arena.allocator();
    defer _ = gpa.deinit();

    const addr = try std.net.Address.parseIp4("127.0.0.1", 8080);
    var server_base = try addr.listen(.{});
    defer server_base.deinit();

    while (true) {
        var conn = try server_base.accept();
        defer conn.stream.close();

        var header_buf: [1024]u8 = undefined;
        var server = std.http.Server.init(conn, &header_buf);
        var req = try server.receiveHead();
        std.debug.print("Headers:\n", .{});
        var headers = req.iterateHeaders();
        while (headers.next()) |header| {
            std.debug.print("\t{s}:{s}\n", .{header.name, header.value});
        }
        const reader = try req.reader();
        var req_buf: [1024]u8 = undefined;
        const n = try reader.readAll(&req_buf);
        std.debug.print("request body len={d} body={s}\n", .{n, req_buf[0..n]});
        try req.respond("", .{
            .status = .ok,
            .extra_headers = &[_]std.http.Header{
                .{ .name="Content-Header", .value="0"},
            },
        });
    }
}
