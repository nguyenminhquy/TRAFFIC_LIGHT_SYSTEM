module manual_mode (
    input sw1,              // Công tắc 1
    input sw2,              // Công tắc 2
    output reg Xa,          // Đèn đỏ làn A
    output reg Va,          // Đèn vàng làn A
    output reg Da,          // Đèn xanh làn A
    output reg Xb,          // Đèn đỏ làn B
    output reg Vb,          // Đèn vàng làn B
    output reg Db           // Đèn xanh làn B
);

always @(*) begin
    if (sw1) begin
        // Nếu sw1 = 1: Làn A xanh, Làn B đỏ
        Xa = 1'b0;
        Va = 1'b0;
        Da = 1'b1;
        Xb = 1'b1;
        Vb = 1'b0;
        Db = 1'b0;
    end else if (sw2) begin
        // Nếu sw2 = 1: Làn A đỏ, Làn B xanh
        Xa = 1'b1;
        Va = 1'b0;
        Da = 1'b0;
        Xb = 1'b0;
        Vb = 1'b0;
        Db = 1'b1;
    end else begin
        // Nếu cả sw1 và sw2 đều tắt
        Xa = 1'b0;
        Va = 1'b0;
        Da = 1'b0;
        Xb = 1'b0;
        Vb = 1'b0;
        Db = 1'b0;
    end
end

endmodule
