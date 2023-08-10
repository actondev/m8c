const std = @import("std");
const net = std.net;
const os = std.os;

const buffer: [1024]u8 = undefined;

pub const io_mode = .evented;

fn debug(comptime msg: []const u8) void {
    std.debug.print(msg, .{});
}

var stream: net.Stream = undefined;

export fn net_init(verbose: c_int) c_int {
    _ = verbose;
    // _ = verbose;
    // debug("net_init");
    std.debug.print("net_init, async {}\n", .{std.io.is_async});
    const address = net.Address.parseIp("127.0.0.1", 1234) catch unreachable;

    stream = net.tcpConnectToAddress(address) catch |err| {
        std.debug.print("connection error: {}\n", .{err});
        return 0;
    };

    return 1;
}

export fn net_check_connection() c_int {
    std.debug.print("net_check_connection\n", .{});
    // stream.handle
    return 1;
}

export fn net_reset_display() c_int {
    _ = stream.write(&.{'R'}) catch |err| {
        std.debug.print("write error {}\n", .{err});
        return 0;
    };
    return 1;
}

export fn net_enable_and_reset_display() c_int {
    _ = stream.write(&.{'E'}) catch |err| {
        std.debug.print("write error {}\n", .{err});
        return 0;
    };
    return net_reset_display();
}

export fn net_disconnect() c_int {
    stream.close();
    return 1;
}

export fn net_read(buf: [*]u8, count: c_int) c_int {
    // std.debug.print("reading.. \n", .{});

    var pfd = [1]os.pollfd{os.pollfd{
        .fd = stream.handle,
        .events = os.POLL.IN,
        .revents = undefined,
    }};
    const poll = os.poll(&pfd, 5) catch |poll_err| {
        std.debug.print("poll err {}\n", .{poll_err});
        return 0;
        // Even poll() didn't work.
    };
    if (poll == 0) {
        // std.debug.print("  poll 0\n", .{});
        return 0;
    }

    // std.debug.print("poll res {}\n", .{poll});

    const bytes = stream.read(buf[0..@as(usize, @intCast(count))]) catch |err| {
        std.debug.print("read error {}\n", .{err});
        return 0;
    };
    // std.debug.print("  read {}\n", .{bytes});
    return @as(c_int, @intCast(bytes));
}

export fn net_send_msg_controller(input: u8) c_int {
    _ = stream.write(&.{ 'C', input }) catch |err| {
        std.debug.print("send error {}\n", .{err});
        return -1;
    };
    return 1;
}

export fn net_send_msg_keyjazz(note: u8, velocity: u8) c_int {
    _ = stream.write(&.{ 'K', note, @min(0x7F, velocity) }) catch |err| {
        std.debug.print("send error {}\n", .{err});
        return -1;
    };

    return 1;
}
