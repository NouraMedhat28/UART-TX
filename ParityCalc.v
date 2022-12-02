module ParityCalc #(
    parameter size = 8
)
(
    input  wire [size-1:0] ParallelData,
    input  wire            DataValid,
    input  wire            ParityType,
    input  wire            CLK,
    input  wire            RST,
    output reg             ParityBit
);

always @(posedge CLK or negedge RST) begin
    if (!RST) begin
        ParityBit <= 'b0;
    end
    //Odd Parity
    if (ParityType && DataValid) begin
        ParityBit <= ~^ParallelData;
    end

    //Even Parity
    else if (!ParityType && DataValid) begin
        ParityBit <= ^ParallelData;
    end

    else  begin
        ParityBit <= ParityBit;
    end
end
endmodule