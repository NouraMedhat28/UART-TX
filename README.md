# UART-TX
UART is Full Duplex protocol (data transmission in both directions 
simultaneously)
<br/>
![Screenshot (101)](https://user-images.githubusercontent.com/96621514/208253842-44676640-7635-4c2c-808a-4e7d3ff2281c.png)
<br/>
<br/>
 Transmitting UART converts parallel data from the master device (eg.
CPU) into serial form and transmit in serial to receiving UART.
<br/>
 Receiving UART will then convert the serial data back into parallel data
for the receiving device.
<br/>
<br/>
![Screenshot (103)](https://user-images.githubusercontent.com/96621514/208253991-42eb6ac6-cd6b-467f-ab3f-b9d00d4bbb82.png)
<br/>
<br/>
<b> Specifications <b/>
<br>
![Screenshot (106)](https://user-images.githubusercontent.com/96621514/208255349-91b3a5d7-d8c5-429f-a172-028494673119.png)
<br/>
<br/>
~ UART TX receive the new data on P_DATA Bus only when Data_Valid Signal is high.
<br/>
~ Registers are cleared using asynchronous active low reset
<br/>
~ Data_Valid is high for only 1 clock cycle
<br/>
~ Busy signal is high as long as UART_TX is transmitting the frame, otherwise low.
<br/>
~ UART_TX couldn't accept any data on P_DATA during UART_TX processing, however Data_Valid get high.
<br/>
~ S_DATA is high in the IDLE case (No transmission).
<br/>
~ PAR_EN (Configuration)
0: To disable frame parity bit
1: To enable frame parity bit
<br/>
~ PAR_TYP (Configuration)
0: Even parity bit
1: Odd parity bit
<br/>
<br/>
<b> Block Diagram <b/>
<br/>
The design mainly consists of 4 block as shown in the following picture:
<br/>
![Screenshot (105)](https://user-images.githubusercontent.com/96621514/208254944-e2089830-534e-4b20-8626-aa4a59275b5f.png)
<br/>
<br/>
- Serializer: Converts parallel data from the master device into serial form.
- Parity Calc: To determine the value of the parity bit.
- FSM: For the sequence of the bits of the frame.
- MUX: To select the proper bit to be on the TX_OUT
