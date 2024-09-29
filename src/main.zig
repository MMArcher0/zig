const std = @import("std");

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

//funcoes por convencao usa-se camelCase variaveis com snake_case
fn printInDebug(name: []const u8, value: anytype) void {
    std.debug.print("{s:>10} {any:^10}\t{}\n", .{ name, value, @TypeOf(value) });
}

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

    std.debug.print("{}\n", .{eight_bit});
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
}
