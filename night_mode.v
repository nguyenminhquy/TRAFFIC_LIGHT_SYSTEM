`timescale 1ns / 1ps

module night_mode(
    input clk,          // Xung đồng hồ
    input reset,        // Tín hiệu reset
    output reg Xa,      // Đèn đỏ làn A
    output reg Va,      // Đèn vàng làn A
    output reg Da,      // Đèn xanh làn A
    output reg Xb,      // Đèn đỏ làn B
    output reg Vb,      // Đèn vàng làn B
    output reg Db       // Đèn xanh làn B
);

    reg [1:0] counter;  // Bộ đếm tạo ra tín hiệu nhấp nháy với 2 chu kỳ
    reg blink_signal;    // Tín hiệu nhấp nháy (1 là bật, 0 là tắt)

    // Logic điều khiển tín hiệu nhấp nháy
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            counter <= 2'd0;
            blink_signal <= 1'b0;
            Xa <= 1'b0;
            Va <= 1'b0;  // Đèn vàng làn A sẽ nhấp nháy
            Da <= 1'b0;
            Xb <= 1'b0;
            Vb <= 1'b0;  // Đèn vàng làn B sẽ nhấp nháy
            Db <= 1'b0;
        end else begin
            // Bộ đếm cho tín hiệu nhấp nháy (2 chu kỳ)
            if (counter == 2'd2) begin
                counter <= 2'd0;  // Reset bộ đếm sau 2 chu kỳ
                blink_signal <= ~blink_signal;  // Đảo tín hiệu nhấp nháy
            end else begin
                counter <= counter + 1;  // Tiếp tục đếm
            end

            // Cập nhật trạng thái của đèn
            if (blink_signal) begin
                // Khi nhấp nháy bật
                Va <= 1'b1;
                Vb <= 1'b1;
            end else begin
                // Khi nhấp nháy tắt
                Va <= 1'b0;
                Vb <= 1'b0;
            end

            // Các đèn khác giữ nguyên
            Xa <= 1'b0;  // Đèn đỏ làn A
            Xb <= 1'b0;  // Đèn đỏ làn B
            Da <= 1'b0;  // Đèn xanh làn A
            Db <= 1'b0;  // Đèn xanh làn B
        end
    end

endmodule
