module FSM (
    input  wire       DataValid,
    input  wire       ParityEn,
    input  wire       SerDone,
    input  wire       CLK,
    input  wire       RST,
    output reg  [1:0] MuxSelection,
    output reg        SerEn,
    output reg        Busy
);

//Internal signals
reg [2:0] PresentState, NextState;

//States Encoding    
localparam IDLE   = 3'b000,
           Start  = 3'b001,
           SerBit = 3'b011,
           Parity = 3'b010,
           Stop   = 3'b110;

//State Transition (Sequential ALways)
always @(posedge CLK or negedge RST) begin
    if (!RST) begin
        PresentState <= IDLE;
        MuxSelection <= 'b01;
        SerEn <= 'b0;
        Busy  <= 'b0;
    end

    else begin
        PresentState <= NextState;
    end
end

//Next state logic (Comb)
always @(*) begin
    case (PresentState)
      IDLE  : begin
        if (DataValid) begin
            NextState = Start;
        end

        else begin
            NextState = IDLE;
        end
      end 

      Start  : begin
        NextState = SerBit;
      end

      SerBit : begin
        if (SerDone) begin
            if (ParityEn) begin
                NextState = Parity;
            end

            else begin
                NextState = Stop;
            end
        end

        else begin
            NextState = SerBit;
        end
      end 

      Parity : begin
        NextState = Stop;
      end

      Stop   : begin
        NextState = IDLE;
      end

      default: begin
        NextState = IDLE;
        end
    endcase
end

//Output logic (Comb always)
always @(*) begin
    case (PresentState)
     IDLE   : begin
        MuxSelection = 2'b01;
        Busy  = 'b0;
        SerEn = 'b0;
     end

     Start  : begin
        MuxSelection = 2'b00;
        Busy  = 'b1;
        SerEn = 'b1;
     end 

     SerBit : begin
        MuxSelection = 2'b10;
        Busy  = 'b1;
        SerEn = 'b1;
        if (SerDone) begin
            SerEn = 'b0;
        end
     end

     Parity : begin
        MuxSelection = 2'b11;
        Busy  = 'b1;
        SerEn = 'b0;
     end

     Stop  : begin
        MuxSelection = 2'b01;
        Busy  = 'b1;
        SerEn = 'b0;
     end
     default: begin
        MuxSelection = 2'b00;
        Busy  = 'b0;
        SerEn = 'b0; 
        end 
    endcase
end

endmodule