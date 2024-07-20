/*
 * Copyright (c) 2024 Matthew Else
 * SPDX-Licence-Identifier: Apache-2.0
 */

module tt_um_vga_example (
    rst_n,
    clk,
    ena,
    ui_in,
    uio_in,
    uo_out,
    uio_out,
    uio_oe
);

    input rst_n;
    input clk;
    input ena;
    input [7:0] ui_in;
    input [7:0] uio_in;
    output [7:0] uo_out;
    output [7:0] uio_out;
    output [7:0] uio_oe;

    wire [7:0] _11;
    wire _92;
    wire _91;
    wire [1:0] _93;
    wire _90;
    wire [2:0] _94;
    wire [3:0] _95;
    wire _86;
    wire _85;
    wire [1:0] _87;
    wire [1:0] _84;
    wire [1:0] _88;
    wire _89;
    wire [4:0] _96;
    wire _80;
    wire _79;
    wire [1:0] _81;
    wire [1:0] _82;
    wire _83;
    wire [5:0] _97;
    wire _74;
    wire [9:0] _30;
    wire _27;
    wire [9:0] _22;
    wire _23;
    wire _24;
    wire [9:0] _19;
    wire _20;
    wire _21;
    wire _25;
    reg _28;
    wire [9:0] _32;
    wire [9:0] _33;
    wire _13;
    wire [9:0] _35;
    wire [9:0] _3;
    reg [9:0] _31;
    wire [9:0] _72;
    wire _73;
    wire [1:0] _75;
    wire [9:0] _44;
    wire [9:0] _41;
    wire _42;
    wire [9:0] _46;
    wire [9:0] _39;
    wire _40;
    wire [9:0] _47;
    wire [9:0] _4;
    reg [9:0] _18;
    wire [9:0] _67;
    wire _68;
    wire _69;
    wire [9:0] _64;
    wire _65;
    wire _66;
    wire _70;
    wire [1:0] _76;
    wire _77;
    wire [6:0] _98;
    wire [9:0] _57;
    wire _58;
    wire _59;
    wire [9:0] _54;
    wire vdd;
    wire _6;
    wire _15;
    wire _8;
    wire [9:0] _51;
    wire _49;
    wire [9:0] _53;
    wire [9:0] _9;
    reg [9:0] _38;
    wire _55;
    wire _56;
    wire _60;
    reg _63;
    wire [7:0] _99;
    assign _11 = 8'b00000000;
    assign _92 = _88[1:1];
    assign _91 = _82[1:1];
    assign _93 = { _91,
                   _92 };
    assign _90 = _76[1:1];
    assign _94 = { _90,
                   _93 };
    assign _95 = { _28,
                   _94 };
    assign _86 = _18[2:2];
    assign _85 = _72[5:5];
    assign _87 = { _85,
                   _86 };
    assign _84 = 2'b00;
    assign _88 = _70 ? _87 : _84;
    assign _89 = _88[0:0];
    assign _96 = { _89,
                   _95 };
    assign _80 = _18[2:2];
    assign _79 = _72[6:6];
    assign _81 = { _79,
                   _80 };
    assign _82 = _70 ? _81 : _84;
    assign _83 = _82[0:0];
    assign _97 = { _83,
                   _96 };
    assign _74 = _18[5:5];
    assign _30 = 10'b0000000000;
    assign _27 = 1'b0;
    assign _22 = 10'b0111101011;
    assign _23 = _22 < _18;
    assign _24 = ~ _23;
    assign _19 = 10'b0111101010;
    assign _20 = _18 < _19;
    assign _21 = ~ _20;
    assign _25 = _21 & _24;
    always @(posedge _8) begin
        if (_15)
            _28 <= _27;
        else
            _28 <= _25;
    end
    assign _32 = 10'b0000000001;
    assign _33 = _31 + _32;
    assign _13 = ~ _6;
    assign _35 = _13 ? _30 : _33;
    assign _3 = _35;
    always @(posedge _28) begin
        _31 <= _3;
    end
    assign _72 = _38 + _31;
    assign _73 = _72[7:7];
    assign _75 = { _73,
                   _74 };
    assign _44 = _18 + _32;
    assign _41 = 10'b1000001100;
    assign _42 = _18 == _41;
    assign _46 = _42 ? _30 : _44;
    assign _39 = 10'b1100011111;
    assign _40 = _38 == _39;
    assign _47 = _40 ? _46 : _18;
    assign _4 = _47;
    always @(posedge _8) begin
        if (_15)
            _18 <= _30;
        else
            _18 <= _4;
    end
    assign _67 = 10'b0111100000;
    assign _68 = _67 < _18;
    assign _69 = ~ _68;
    assign _64 = 10'b1010000000;
    assign _65 = _64 < _38;
    assign _66 = ~ _65;
    assign _70 = _66 & _69;
    assign _76 = _70 ? _75 : _84;
    assign _77 = _76[0:0];
    assign _98 = { _77,
                   _97 };
    assign _57 = 10'b1011101111;
    assign _58 = _57 < _38;
    assign _59 = ~ _58;
    assign _54 = 10'b1010010000;
    assign vdd = 1'b1;
    assign _6 = rst_n;
    assign _15 = ~ _6;
    assign _8 = clk;
    assign _51 = _38 + _32;
    assign _49 = _38 == _39;
    assign _53 = _49 ? _30 : _51;
    assign _9 = _53;
    always @(posedge _8) begin
        if (_15)
            _38 <= _30;
        else
            _38 <= _9;
    end
    assign _55 = _38 < _54;
    assign _56 = ~ _55;
    assign _60 = _56 & _59;
    always @(posedge _8) begin
        if (_15)
            _63 <= _27;
        else
            _63 <= _60;
    end
    assign _99 = { _63,
                   _98 };
    assign uo_out = _99;
    assign uio_out = _11;
    assign uio_oe = _11;

endmodule
