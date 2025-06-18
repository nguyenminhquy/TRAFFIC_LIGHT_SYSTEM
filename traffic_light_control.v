module traffic_light_control (
    input clk,
    input reset,
    input btn1,
    input btn2,
    input btn3,
    input sw1,
    input sw2,
    output reg Xa,
    output reg Va,
    output reg Da,
    output reg Xb,
    output reg Vb,
    output reg Db,
    output reg [6:0] segA1,
    output reg [6:0] segA0,
    output reg [6:0] segB1,
    output reg [6:0] segB0
);

reg auto_mode;
reg night_mode;
reg manual_mode;

wire Xa_auto, Va_auto, Da_auto, Xb_auto, Vb_auto, Db_auto;
wire Xa_night, Va_night, Da_night, Xb_night, Vb_night, Db_night;
wire Xa_manual, Va_manual, Da_manual, Xb_manual, Vb_manual, Db_manual;
wire [6:0] segA1_auto, segA0_auto, segB1_auto, segB0_auto;

fsm_auto_mode fsm_auto_inst (
    .clk(clk),
    .reset(reset),
    .Xa(Xa_auto),
    .Va(Va_auto),
    .Da(Da_auto),
    .Xb(Xb_auto),
    .Vb(Vb_auto),
    .Db(Db_auto),
    .segA1(segA1_auto),
    .segA0(segA0_auto),
    .segB1(segB1_auto),
    .segB0(segB0_auto)
);

night_mode night_mode_inst (
    .clk(clk),
    .reset(reset),
    .Xa(Xa_night),
    .Va(Va_night),
    .Da(Da_night),
    .Xb(Xb_night),
    .Vb(Vb_night),
    .Db(Db_night)
);

manual_mode manual_mode_inst (
    .sw1(sw1),
    .sw2(sw2),
    .Xa(Xa_manual),
    .Va(Va_manual),
    .Da(Da_manual),
    .Xb(Xb_manual),
    .Vb(Vb_manual),
    .Db(Db_manual)
);

always @(posedge clk or posedge reset) begin
    if (reset) begin
        auto_mode <= 1'b0;
        night_mode <= 1'b0;
        manual_mode <= 1'b0;
    end else begin
        if (btn1) begin
            auto_mode <= 1'b1;
            night_mode <= 1'b0;
            manual_mode <= 1'b0;
        end else if (btn2) begin
            night_mode <= 1'b1;
            auto_mode <= 1'b0;
            manual_mode <= 1'b0;
        end else if (btn3) begin
            manual_mode <= 1'b1;
            auto_mode <= 1'b0;
            night_mode <= 1'b0;
        end
    end
end

always @(*) begin
    if (manual_mode) begin
        Xa = Xa_manual;
        Va = Va_manual;
        Da = Da_manual;
        Xb = Xb_manual;
        Vb = Vb_manual;
        Db = Db_manual;
        segA1 = 7'b0000000;
        segA0 = 7'b0000000;
        segB1 = 7'b0000000;
        segB0 = 7'b0000000;

    end else if (night_mode) begin
        Xa = Xa_night;
        Va = Va_night;
        Da = Da_night;
        Xb = Xb_night;
        Vb = Vb_night;
        Db = Db_night;
        segA1 = 7'b0000000;
        segA0 = 7'b0000000;
        segB1 = 7'b0000000;
        segB0 = 7'b0000000;

    end else if (auto_mode) begin
        Xa = Xa_auto;
        Va = Va_auto;
        Da = Da_auto;
        Xb = Xb_auto;
        Vb = Vb_auto;
        Db = Db_auto;
        segA1 = segA1_auto;
        segA0 = segA0_auto;
        segB1 = segB1_auto;
        segB0 = segB0_auto;
    end else begin
        Xa = 1'b0;
        Va = 1'b0;
        Da = 1'b0;
        Xb = 1'b0;
        Vb = 1'b0;
        Db = 1'b0;
        segA1 = 7'b1111111;
        segA0 = 7'b1111111;
        segB1 = 7'b1111111;
        segB0 = 7'b1111111;
    end
end

endmodule
