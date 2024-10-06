x: f32,
y: f32 = 0,

const Point = @This();

pub fn new(x: f32, y: f32) Point {
    return .{ .x = x, .y = y };
}

pub fn distance(self: Point, other: Point) f32 {
    const difx = other.x - self.x;
    const dify = other.y - self.y;
    return @sqrt(difx * difx + dify * dify);
}
