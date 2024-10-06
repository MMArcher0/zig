const std = @import("std");
const Point = @import("Point.zig");
const PointGeneric = @import("PointGenetric.zig").PointGeneric(i16);

//Variaveis globais
// u8 = unsigned 8bit integer
// 8 bits para o numero, armazena de 0 ate 255
// const e imutavel var e mutavel
const global_const: u8 = 40;
var global_var: u8 = 0;

const Color = enum {
    red,
    green,
    blue,
    fn isRed(self: Color) bool {
        return self == .red;
    }
};

const Number = union {
    int: u8,
    float: f64,
};

const Token = union(enum) {
    keyword_if,
    keyword_switch: void,
    digit: usize,

    fn is(self: Token, tag: std.meta.Tag(Token)) bool {
        return self == tag;
    }
};

const Namespace = struct {
    const pi: f64 = 3.141592;
    var count: usize = 0;
};

//funcoes por convencao usa-se camelCase variaveis com snake_case
fn printInDebug(name: []const u8, value: anytype) void {
    std.debug.print("{s:>10} {any:^10}\t{}\n", .{ name, value, @TypeOf(value) });
}

//const Point = struct {
//    x: f32,
//    y: f32 = 0,
//
//    fn new(x: f32, y: f32) Point {
//        return .{ .x = x, .y = y };
//    }
//
//    fn distance(self: Point, other: Point) f32 {
//        const difx = other.x - self.x;
//        const dify = other.y - self.y;
//        return @sqrt(difx * difx + dify * dify);
//    }
//};

pub fn main() !void {

    //Label para a fn printInDebug
    std.debug.print("{s:>10} {s:^10}\t{s}\n", .{ "name", "value", "type" });
    std.debug.print("{s:>10} {s:^10}\t{s}\n", .{ "----", "-----", "----" });

    //const e var sem uso causa erro
    //não é obrigatório colocar tipo, se não colocar vira comptime_int
    //var não pode ser comptime_int apenas const ou comptime
    //variaveis devem ser iniciadas com algum valor
    //se não possuir o valor ainda, pode ser iniciada como undefined
    const a_const = 1;
    var a_var: u8 = 2;

    printInDebug("a_const", a_const);

    a_var += 1;
    printInDebug("a_var", a_var);

    var sixteen_bit: u16 = 0;
    sixteen_bit -%= 1;
    const eight_bit: u8 = 83;
    const sixteen_bit_ptr = &sixteen_bit;
    sixteen_bit_ptr.* +%= 1;

    std.debug.print("{}\n", .{eight_bit});
    std.debug.print("from pointer +1 {}\n", .{sixteen_bit_ptr.*});
    std.debug.print("{}\n", .{sixteen_bit});

    const maybe: ?u8 = 25;
    if (maybe) |value| {
        std.debug.print("not null{}\n", .{value});
    } else {
        std.debug.print("null\n", .{});
    }

    switch (eight_bit) {
        0...50 => std.debug.print("entre 0 e 50\n", .{}),
        51, 52, 53 => std.debug.print("é 51 52 ou 53\n", .{}),
        54...80 => |n| std.debug.print("é {}\n", .{n}),
        81, 82, 83 => |n| {
            const dobro: u8 = n *| 2;
            std.debug.print("dobro de {} e {}\n", .{ n, dobro });
        },
        else => |n| std.debug.print("{} não faz nada\n", .{n}),
    }

    var my_color: Color = .green;
    std.debug.print("{s} is red? {}\n", .{ @tagName(my_color), my_color.isRed() });
    my_color = .red;
    std.debug.print("{s} is red? {}\n", .{ @tagName(my_color), my_color.isRed() });

    std.debug.print("{} is the color number\n", .{@intFromEnum(my_color)});

    switch (my_color) {
        .blue => std.debug.print("is blue\n", .{}),
        .green => std.debug.print("is green\n", .{}),
        .red => std.debug.print("is red\n", .{}),
    }

    var my_num: Number = .{ .int = 12 };
    std.debug.print("my int is {}\n", .{my_num.int});
    my_num = .{ .float = 3.1214 };
    std.debug.print("my float is {}\n", .{my_num.float});

    var tok: Token = .keyword_if;

    std.debug.print("is if{}\n", .{tok.is(.keyword_if)}); //zls mostra erro, mas compila corretamente no .keyword_if

    tok = .{ .digit = 42 };

    switch (tok) {
        .digit => |v| std.debug.print("is {}\n", .{v}),
        .keyword_if => std.debug.print("is if\n", .{}),
        .keyword_switch => std.debug.print("is switch\n", .{}),
    }

    const a: u8 = 0;
    const a_ptr = &a;
    std.debug.print("aptr: {} type of aptr: {}\n", .{ a_ptr.*, @TypeOf(a_ptr) });

    var b: u8 = 0;
    const b_ptr = &b;
    b_ptr.* += 1;
    std.debug.print("bptr: {} type of bptr: {}\n", .{ b_ptr.*, @TypeOf(b_ptr) });

    var c_ptr = a_ptr;
    c_ptr = b_ptr;
    std.debug.print("cptr: {} type of cptr: {}\n", .{ c_ptr.*, @TypeOf(c_ptr) });

    var array = [_]u8{ 1, 2, 3, 4, 5, 6 };
    var d_ptr: [*]u8 = &array;
    std.debug.print("dptr: {} type of dptr: {}\n", .{ d_ptr[0], @TypeOf(d_ptr) });
    d_ptr[1] += 1;
    d_ptr += 1;
    std.debug.print("dptr: {} type of dptr: {}\n", .{ d_ptr[0], @TypeOf(d_ptr) });
    d_ptr -= 1;
    std.debug.print("dptr: {} type of dptr: {}\n", .{ d_ptr[0], @TypeOf(d_ptr) });

    const e_ptr = &array;
    std.debug.print("eptr: {} type of eptr: {}\n", .{ e_ptr[0], @TypeOf(e_ptr) });
    e_ptr[1] += 1;
    std.debug.print("eptr: {} type of eptr: {}\n", .{ e_ptr[1], @TypeOf(e_ptr) });
    std.debug.print("eptr: {} type of eptr: {}\n", .{ d_ptr[1], @TypeOf(e_ptr) });
    std.debug.print("eptr len: {}\n", .{e_ptr.len});

    const arr_ptr = array[0..array.len];
    std.debug.print("type of arrptr: {}\n", .{@TypeOf(arr_ptr)});

    for (array) |v| std.debug.print("tvalue: {}\n", .{v});

    for (d_ptr[0..3]) |v| std.debug.print("tvalue: {}\n", .{v});

    for (d_ptr[0..2], d_ptr[1..3], d_ptr[2..4]) |v1, v2, v3| std.debug.print("triple value: {} {} {}\n", .{ v1, v2, v3 });

    for (0..3) |v| std.debug.print("tvalue: {}\n", .{v});

    const tenqv = [_]?u8{ 1, 2, 3, null, null };

    const sonum = for (tenqv, 0..) |v, i| {
        if (v == null) break tenqv[0..i];
    } else tenqv[0..];
    std.debug.print("num e null: {any}\n", .{tenqv});
    std.debug.print("so num : {any}\n", .{sonum});

    var i: usize = 0;
    while (i < 5) : (i += 1) std.debug.print("dentro do while : {}\n", .{i});

    i = 0;

    outer_while: while (true) : (i += 1) {
        while (i < 10) : (i += 1) {
            if (i == 4) continue :outer_while;
            if (i == 6) break :outer_while;
            std.debug.print("{}", .{i});
        }
    }
    std.debug.print("\n", .{});

    const a_point: PointGeneric = .{ .x = 8, .y = 2 };

    const b_point = PointGeneric.new(3, 4);

    std.debug.print("distance: {d:.1}\n", .{a_point.distance(b_point)});

    std.debug.print("size point: {}\n", .{@sizeOf(Point)});
    std.debug.print("size namespace: {}\n", .{@sizeOf(Namespace)});
}
