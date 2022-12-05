module MUX (
    input  wire [1:0] MuxSelection,
    input  wire       SerData,
    input  wire       ParityBit,
    output reg        TXOut
);

reg StartBit;
reg StopBit;

//MUX Logic
    always @(*) begin
    StartBit = 'b0;
    StopBit  = 'b1;
    case (MuxSelection)
      2'b00 : begin
        TXOut <= StartBit;
      end 

      2'b01 : begin
        TXOut <= StopBit;
      end

      2'b10 : begin
        TXOut <= SerData;
      end

      2'b11 : begin
        TXOut <= ParityBit;
      end

      default : begin
        TXOut <= 'b0;
      end
    endcase  
    end
    
    
endmodule