module UART_TX #(
    parameter size = 8
) (
   input  wire            CLK,
   input  wire            RST,
   input  wire [size-1:0] ParallelData,
   input  wire            ParityType,
   input  wire            ParityEn,
   input  wire            DataValid,
   output wire            Busy,
   output wire            TXOut
);

wire       ParityBit;
wire       SerEn;
wire       SerData;
wire       SerDone;
wire [1:0] MuxSelection;

ParityCalc        #(.size(size))    ParityCalcTop
( .ParallelData    (ParallelData),
  .DataValid       (DataValid),
  .ParityType      (ParityType),
  .CLK             (CLK),
  .RST             (RST),
  .ParityBit       (ParityBit)
);

Serializer        #(.size(size))    SerializerTop
( .ParallelData    (ParallelData),
  .DataValid       (DataValid),
  .SerEn           (SerEn),
  .CLK             (CLK),
  .RST             (RST),
  .SerDone         (SerDone),
  .SerData         (SerData)
);

MUX                                MuxTop
( .MuxSelection    (MuxSelection),
  .SerData         (SerData),
  .ParityBit       (ParityBit),
  .TXOut           (TXOut)
);

FSM                                FSMTop
( .DataValid       (DataValid),
  .ParityEn        (ParityEn),
  .SerDone         (SerDone),
  .CLK             (CLK),
  .RST             (RST),
  .MuxSelection    (MuxSelection),
  .SerEn           (SerEn),
  .Busy            (Busy)
);
endmodule