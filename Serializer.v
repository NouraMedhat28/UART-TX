module Serializer #(
    parameter size =8
)
(
    input  wire [size-1:0] ParallelData,
    input  wire            DataValid,
    input  wire            SerEn,
    input  wire            CLK,
    input  wire            RST,
    output reg             SerDone,
    output reg             SerData
);

//Internal Signals
reg [size-1:0] parallel;
reg [2:0]      counter;

//initialization always block
always @(*) begin
    if (DataValid) begin
        parallel = ParallelData;
        counter  = 'b0;
    end
    else begin
        SerData = SerData;
    end    
end

always @(posedge CLK or negedge RST) begin
    //Asynchronous active low reset
    if (!RST) begin
        SerData <= 'b0;
        SerDone <= 'b0;
    end

    //Serializer Logic
    else if (SerEn) begin
        if (counter == 'b111) begin
            SerData = parallel[0];
            SerDone <= 'b1; 
        end
        else begin
            SerData = parallel[0];
            parallel <= parallel>>1; 
            counter  <= counter +1;
            SerDone  <= 'b0;
        end
    end

    else begin
        SerData <= SerData;
        SerDone <= 'b0;
    end
end    

endmodule