`timescale 1ns/1ns

module tb_risc_v;
 reg clk,r;
reg [31:0] pmdr,dmdr; // data in from Program memory (PM) and Data memory (DM)
 wire dmr; // read enable 
 wire [1:0] dmw; // write enable considering bus width of 8,16,32 
 wire [31:0] dmdw;  //data for write to data memory
wire [15:0] pmar,dmar,dmaw; // address for pm read, dm read and dm write
 reg[7:0] mem[65535:0] ; 

integer i;

 self_check uut (
        .clk(clk),
        .r(r),
        .pmdr(pmdr),
        .dmdr(dmdr), // data in from Program memory (PM) and Data memory (DM)
        .dmrs(dmr), // read enable 
        .dmws(dmw), // write enable considering bus width of 8,16,32 
        .dmdws(dmdw),  //data for write to data memory
        .pmars(pmar),
        .dmars(dmar),
        .dmaws(dmaw) // address for pm read, dm read and dm write

        );

always @ (posedge clk) 
begin
 pmdr<={mem[pmar+3],mem[pmar+2],mem[pmar+1],mem[pmar+0]};
 dmdr<={mem[dmar+3],mem[dmar+2],mem[dmar+1],mem[dmar+0]}; 
end

always @ (posedge clk) 
case(dmw)
 0 :; 
 1 : mem[dmaw]<=dmdw[7:0];
 2 : begin mem[dmaw]<=dmdw[7:0]; mem[dmaw+1]<=dmdw[15:8]; end 
 3 : begin mem[dmaw]<=dmdw[7:0]; mem[dmaw+1]<=dmdw[15:8]; mem[dmaw+2]<=dmdw[23:16]; mem[dmaw+3]<=dmdw[31:24]; end
endcase
 
always #5 clk=~clk;
     


     
initial begin

for (i=0;i<65536;i=i+4)
begin mem[i+0]=8'h13;mem[i+1]=8'h00;mem[i+2]=8'h00; mem[i+3]=8'h00; end
pmdr=0; dmdr=0;
mem[0]=8'hb3;mem[1]=8'h00;mem[2]=8'hf1; mem[3]=8'h01; // x1=x2+x31
mem[4]=8'h93;mem[5]=8'h8f;mem[6]=8'h80; mem[7]=8'h00; // x31=x1+8
mem[8]=8'hb3;mem[9]=8'hdf;mem[10]=8'h20; mem[11]=8'h20; // x31=x1>>x2
mem[12]=8'h03;mem[13]=8'h91;mem[14]=8'h4f; mem[15]=8'h00; // x2=m[x31+4][0:15]
mem[16]=8'hb3;mem[17]=8'h80;mem[18]=8'h2f; mem[19]=8'h40; //x1=x31-x2
mem[20]=8'h93;mem[21]=8'hff;mem[22]=8'h60; mem[23]=8'h00;// x31= x1 & 6
mem[24]=8'ha3;mem[25]=8'h84;mem[26]=8'h2f; mem[27]=8'h00; // x2=m[x31+9]
mem[28]=8'h63;mem[29]=8'h65;mem[30]=8'h11; mem[31]=8'h00; // if (x2< x1) pc+=5

//mem[0]=8'he7;mem[1]=8'h8f;mem[2]=8'h30; mem[3]=8'h00; //32'hfedcb117; //32'h00208263; //32'h002081a3; //32'h0020a1a3; //32'h00110083; //32'h0020a103; //32'h00208fb3;
//mem[4]=8'h33;mem[5]=8'h81;mem[6]=8'h2f; mem[7]=8'h40; 
/*mem[2]=32'h00610093;
mem[3]=32'h0020df93;
mem[4]=32'h0011a133;
mem[5]=32'h0030a133;*/


        clk = 0;
        r = 0;
   
        #10 r = 1;
         
         
         
         
 end        
endmodule
