const std = @import("std");

//Variaveis globais
// u8 = unsigned 8bit integer
// 8 bits para o numero, armazena de 0 ate 255
// const e imutavel var e mutavel
const global_const: u8 = 40;
var global_var: u8 = 0;

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

    const sixteen_bit: u16 = 0b1111_1111_1111_1111;
    const eight_bit: u8 = 255;

    std.debug.print("{}\n", .{eight_bit});
    std.debug.print("{}\n", .{sixteen_bit});

    // Prints to stderr (it's a shortcut based on `std.io.getStdErr()`)
    //std.debug.print("All your {s} are belong to us.\n", .{"codebase"});

    // stdout is for the actual output of your application, for example if you
    // are implementing gzip, then only the compressed bytes should be sent to
    // stdout, not any debugging messages.
    //const stdout_file = std.io.getStdOut().writer();
    //var bw = std.io.bufferedWriter(stdout_file);
    //const stdout = bw.writer();

    //try stdout.print("Run `zig build test` to run the tests.\n", .{});

    //try bw.flush(); // Don't forget to flush!
}
