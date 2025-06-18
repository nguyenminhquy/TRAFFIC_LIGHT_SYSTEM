module fsm_auto_mode(
    input clk,
    input reset,
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

    reg [7:0] counterA;    // Bộ đếm thời gian cho làn A
    reg [7:0] counterB;    // Bộ đếm thời gian cho làn B
    reg [1:0] state;      // Trạng thái hiện tại

    localparam A_GREEN = 2'b00;
    localparam A_YELLOW = 2'b01;
    localparam B_GREEN = 2'b10;
    localparam B_YELLOW = 2'b11;
    localparam TIME_GREEN = 8'd15;
    localparam TIME_YELLOW = 8'd3;

    reg [6:0] seg [0:9];  // Mảng lưu mã 7 đoạn
    initial begin
        seg[0] = 7'b0000001;  // Mã 7 đoạn cho số 0
        seg[1] = 7'b1001111;  // Mã 7 đoạn cho số 1
        seg[2] = 7'b0010010;  // Mã 7 đoạn cho số 2
        seg[3] = 7'b0000110;  // Mã 7 đoạn cho số 3
        seg[4] = 7'b1001100;  // Mã 7 đoạn cho số 4
        seg[5] = 7'b0100100;  // Mã 7 đoạn cho số 5
        seg[6] = 7'b0100000;  // Mã 7 đoạn cho số 6
        seg[7] = 7'b0001111;  // Mã 7 đoạn cho số 7
        seg[8] = 7'b0000000;  // Mã 7 đoạn cho số 8
        seg[9] = 7'b0000100;  // Mã 7 đoạn cho số 9
    end

    initial begin
        Xa = 1'b0;
        Va = 1'b0;
        Da = 1'b0;
        Xb = 1'b0;
        Vb = 1'b0;
        Db = 1'b0;
        counterA = 8'd0;
        counterB = 8'd0;
        state = A_GREEN;
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Reset tất cả các tín hiệu và bộ đếm khi reset
            Xa <= 1'b0;
            Va <= 1'b0;
            Da <= 1'b0;
            Xb <= 1'b0;
            Vb <= 1'b0;
            Db <= 1'b0;
            counterA <= 8'd0;
            counterB <= 8'd0;
            state <= A_GREEN;
        end else begin
            // Cập nhật bộ đếm của mỗi lane
            if (state == A_GREEN || state == A_YELLOW)
                counterA <= counterA + 1;
            else
                counterA <= 8'd0;

            if (state == B_GREEN || state == B_YELLOW)
                counterB <= counterB + 1;
            else
                counterB <= 8'd0;

            case (state)
                A_GREEN: begin
                    if (counterA < TIME_GREEN) begin
                        Xa <= 1'b1;
                        Va <= 1'b0;
                        Da <= 1'b0;
                        Xb <= 1'b0;
                        Vb <= 1'b0;
                        Db <= 1'b1;

                        // Cập nhật LED 7 đoạn cho làn A
                        segA1 <= seg[counterA / 10]; // Chục
                        segA0 <= seg[counterA % 10]; // Đơn vị
                    end else begin
                        state <= A_YELLOW;
                        counterA <= 8'd0;
                    end
                end
                A_YELLOW: begin
                    if (counterA < TIME_YELLOW) begin
                        Xa <= 1'b0;
                        Va <= 1'b1;
                        Da <= 1'b0;
                        Xb <= 1'b0;
                        Vb <= 1'b0;
                        Db <= 1'b1;

                        // Cập nhật LED 7 đoạn cho làn A
                        segA1 <= seg[counterA / 10]; // Chục
                        segA0 <= seg[counterA % 10]; // Đơn vị
                    end else begin
                        state <= B_GREEN;
                        counterA <= 8'd0;
                    end
                end
                B_GREEN: begin
                    if (counterB < TIME_GREEN) begin
                        Xa <= 1'b0;
                        Va <= 1'b0;
                        Da <= 1'b1;
                        Xb <= 1'b1;
                        Vb <= 1'b0;
                        Db <= 1'b0;

                        // Cập nhật LED 7 đoạn cho làn B
                        segB1 <= seg[counterB / 10]; // Chục
                        segB0 <= seg[counterB % 10]; // Đơn vị
                    end else begin
                        state <= B_YELLOW;
                        counterB <= 8'd0;
                    end
                end
                B_YELLOW: begin
                    if (counterB < TIME_YELLOW) begin
                        Xa <= 1'b0;
                        Va <= 1'b0;
                        Da <= 1'b1;
                        Xb <= 1'b0;
                        Vb <= 1'b1;
                        Db <= 1'b0;

                        // Cập nhật LED 7 đoạn cho làn B
                        segB1 <= seg[counterB / 10]; // Chục
                        segB0 <= seg[counterB % 10]; // Đơn vị
                    end else begin
                        state <= A_GREEN;
                        counterB <= 8'd0;
                    end
                end
            endcase
        end
    end
endmodule
