const std = @import("std");
// pub const io_mode = std.io.Mode.evented;

pub const std_options = struct {
    const std = @import("std");
    // pub const log_level: std.log.Level = .info;
    // pub const io_mode = .evented;
};

const c = @cImport({
    @cInclude("main.h");
});

pub fn main() !u8 {
    const res = c.cmain(0, null);
    return @as(u8, @intCast(res));
}
