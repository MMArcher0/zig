pub fn PointGeneric(comptime T: type) type {
    return struct {
        x: T,
        y: T = 0,

        const Self = @This();

        pub fn new(x: T, y: T) Self {
            return .{ .x = x, .y = y };
        }

        pub fn distance(self: Self, other: Self) f64 {
            const dify: f64 = switch (@typeInfo(T)) {
                .int => @floatFromInt(other.y - self.y),
                .float => other.y - self.y,
                else => @compileError("ta errado isso dai em "),
            };
            const difx: f64 = switch (@typeInfo(T)) {
                .int => @floatFromInt(other.x - self.x),
                .float => other.x - self.x,
                else => @compileError("ta errado isso dai em "),
            };
            // const difx = other.x - self.x;
            // const dify = other.y - self.y;
            if (difx == 0 or dify == 0) return dify + difx;
            return @sqrt(difx * difx + dify * dify);
        }
    };
}
