const std = @import("std");
const c = @cImport({
    @cInclude("main.h");
});

pub fn main() !u8 {
    const res = c.cmain(0, null);
    return @as(u8, @intCast(res));
}
