// Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2021.2 (win64) Build 3367213 Tue Oct 19 02:48:09 MDT 2021
// Date        : Sat Feb 12 20:46:00 2022
// Host        : YMLap running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               e:/Diplomarbeit/HTMega/HTMega_FPGA/HTMega_FPGA.gen/sources_1/ip/GPREG_IP/GPREG_IP_sim_netlist.v
// Design      : GPREG_IP
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "GPREG_IP,blk_mem_gen_v8_4_5,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_5,Vivado 2021.2" *) 
(* NotValidForBitStream *)
module GPREG_IP
   (clka,
    ena,
    wea,
    addra,
    dina,
    douta);
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTA, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *) input clka;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA EN" *) input ena;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA WE" *) input [0:0]wea;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA ADDR" *) input [7:0]addra;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DIN" *) input [15:0]dina;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DOUT" *) output [15:0]douta;

  wire [7:0]addra;
  wire clka;
  wire [15:0]dina;
  wire [15:0]douta;
  wire ena;
  wire [0:0]wea;
  wire NLW_U0_dbiterr_UNCONNECTED;
  wire NLW_U0_rsta_busy_UNCONNECTED;
  wire NLW_U0_rstb_busy_UNCONNECTED;
  wire NLW_U0_s_axi_arready_UNCONNECTED;
  wire NLW_U0_s_axi_awready_UNCONNECTED;
  wire NLW_U0_s_axi_bvalid_UNCONNECTED;
  wire NLW_U0_s_axi_dbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_rlast_UNCONNECTED;
  wire NLW_U0_s_axi_rvalid_UNCONNECTED;
  wire NLW_U0_s_axi_sbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_wready_UNCONNECTED;
  wire NLW_U0_sbiterr_UNCONNECTED;
  wire [15:0]NLW_U0_doutb_UNCONNECTED;
  wire [7:0]NLW_U0_rdaddrecc_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_bid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_bresp_UNCONNECTED;
  wire [7:0]NLW_U0_s_axi_rdaddrecc_UNCONNECTED;
  wire [15:0]NLW_U0_s_axi_rdata_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_rid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_rresp_UNCONNECTED;

  (* C_ADDRA_WIDTH = "8" *) 
  (* C_ADDRB_WIDTH = "8" *) 
  (* C_ALGORITHM = "1" *) 
  (* C_AXI_ID_WIDTH = "4" *) 
  (* C_AXI_SLAVE_TYPE = "0" *) 
  (* C_AXI_TYPE = "1" *) 
  (* C_BYTE_SIZE = "9" *) 
  (* C_COMMON_CLK = "0" *) 
  (* C_COUNT_18K_BRAM = "1" *) 
  (* C_COUNT_36K_BRAM = "0" *) 
  (* C_CTRL_ECC_ALGO = "NONE" *) 
  (* C_DEFAULT_DATA = "0" *) 
  (* C_DISABLE_WARN_BHV_COLL = "0" *) 
  (* C_DISABLE_WARN_BHV_RANGE = "0" *) 
  (* C_ELABORATION_DIR = "./" *) 
  (* C_ENABLE_32BIT_ADDRESS = "0" *) 
  (* C_EN_DEEPSLEEP_PIN = "0" *) 
  (* C_EN_ECC_PIPE = "0" *) 
  (* C_EN_RDADDRA_CHG = "0" *) 
  (* C_EN_RDADDRB_CHG = "0" *) 
  (* C_EN_SAFETY_CKT = "0" *) 
  (* C_EN_SHUTDOWN_PIN = "0" *) 
  (* C_EN_SLEEP_PIN = "0" *) 
  (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     2.87285 mW" *) 
  (* C_FAMILY = "artix7" *) 
  (* C_HAS_AXI_ID = "0" *) 
  (* C_HAS_ENA = "1" *) 
  (* C_HAS_ENB = "0" *) 
  (* C_HAS_INJECTERR = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_REGCEA = "0" *) 
  (* C_HAS_REGCEB = "0" *) 
  (* C_HAS_RSTA = "0" *) 
  (* C_HAS_RSTB = "0" *) 
  (* C_HAS_SOFTECC_INPUT_REGS_A = "0" *) 
  (* C_HAS_SOFTECC_OUTPUT_REGS_B = "0" *) 
  (* C_INITA_VAL = "0" *) 
  (* C_INITB_VAL = "0" *) 
  (* C_INIT_FILE = "GPREG_IP.mem" *) 
  (* C_INIT_FILE_NAME = "no_coe_file_loaded" *) 
  (* C_INTERFACE_TYPE = "0" *) 
  (* C_LOAD_INIT_FILE = "0" *) 
  (* C_MEM_TYPE = "0" *) 
  (* C_MUX_PIPELINE_STAGES = "0" *) 
  (* C_PRIM_TYPE = "1" *) 
  (* C_READ_DEPTH_A = "224" *) 
  (* C_READ_DEPTH_B = "224" *) 
  (* C_READ_LATENCY_A = "1" *) 
  (* C_READ_LATENCY_B = "1" *) 
  (* C_READ_WIDTH_A = "16" *) 
  (* C_READ_WIDTH_B = "16" *) 
  (* C_RSTRAM_A = "0" *) 
  (* C_RSTRAM_B = "0" *) 
  (* C_RST_PRIORITY_A = "CE" *) 
  (* C_RST_PRIORITY_B = "CE" *) 
  (* C_SIM_COLLISION_CHECK = "ALL" *) 
  (* C_USE_BRAM_BLOCK = "0" *) 
  (* C_USE_BYTE_WEA = "0" *) 
  (* C_USE_BYTE_WEB = "0" *) 
  (* C_USE_DEFAULT_DATA = "0" *) 
  (* C_USE_ECC = "0" *) 
  (* C_USE_SOFTECC = "0" *) 
  (* C_USE_URAM = "0" *) 
  (* C_WEA_WIDTH = "1" *) 
  (* C_WEB_WIDTH = "1" *) 
  (* C_WRITE_DEPTH_A = "224" *) 
  (* C_WRITE_DEPTH_B = "224" *) 
  (* C_WRITE_MODE_A = "WRITE_FIRST" *) 
  (* C_WRITE_MODE_B = "WRITE_FIRST" *) 
  (* C_WRITE_WIDTH_A = "16" *) 
  (* C_WRITE_WIDTH_B = "16" *) 
  (* C_XDEVICEFAMILY = "artix7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  (* is_du_within_envelope = "true" *) 
  GPREG_IP_blk_mem_gen_v8_4_5 U0
       (.addra(addra),
        .addrb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .clka(clka),
        .clkb(1'b0),
        .dbiterr(NLW_U0_dbiterr_UNCONNECTED),
        .deepsleep(1'b0),
        .dina(dina),
        .dinb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .douta(douta),
        .doutb(NLW_U0_doutb_UNCONNECTED[15:0]),
        .eccpipece(1'b0),
        .ena(ena),
        .enb(1'b0),
        .injectdbiterr(1'b0),
        .injectsbiterr(1'b0),
        .rdaddrecc(NLW_U0_rdaddrecc_UNCONNECTED[7:0]),
        .regcea(1'b0),
        .regceb(1'b0),
        .rsta(1'b0),
        .rsta_busy(NLW_U0_rsta_busy_UNCONNECTED),
        .rstb(1'b0),
        .rstb_busy(NLW_U0_rstb_busy_UNCONNECTED),
        .s_aclk(1'b0),
        .s_aresetn(1'b0),
        .s_axi_araddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arburst({1'b0,1'b0}),
        .s_axi_arid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arready(NLW_U0_s_axi_arready_UNCONNECTED),
        .s_axi_arsize({1'b0,1'b0,1'b0}),
        .s_axi_arvalid(1'b0),
        .s_axi_awaddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awburst({1'b0,1'b0}),
        .s_axi_awid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awready(NLW_U0_s_axi_awready_UNCONNECTED),
        .s_axi_awsize({1'b0,1'b0,1'b0}),
        .s_axi_awvalid(1'b0),
        .s_axi_bid(NLW_U0_s_axi_bid_UNCONNECTED[3:0]),
        .s_axi_bready(1'b0),
        .s_axi_bresp(NLW_U0_s_axi_bresp_UNCONNECTED[1:0]),
        .s_axi_bvalid(NLW_U0_s_axi_bvalid_UNCONNECTED),
        .s_axi_dbiterr(NLW_U0_s_axi_dbiterr_UNCONNECTED),
        .s_axi_injectdbiterr(1'b0),
        .s_axi_injectsbiterr(1'b0),
        .s_axi_rdaddrecc(NLW_U0_s_axi_rdaddrecc_UNCONNECTED[7:0]),
        .s_axi_rdata(NLW_U0_s_axi_rdata_UNCONNECTED[15:0]),
        .s_axi_rid(NLW_U0_s_axi_rid_UNCONNECTED[3:0]),
        .s_axi_rlast(NLW_U0_s_axi_rlast_UNCONNECTED),
        .s_axi_rready(1'b0),
        .s_axi_rresp(NLW_U0_s_axi_rresp_UNCONNECTED[1:0]),
        .s_axi_rvalid(NLW_U0_s_axi_rvalid_UNCONNECTED),
        .s_axi_sbiterr(NLW_U0_s_axi_sbiterr_UNCONNECTED),
        .s_axi_wdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_wlast(1'b0),
        .s_axi_wready(NLW_U0_s_axi_wready_UNCONNECTED),
        .s_axi_wstrb(1'b0),
        .s_axi_wvalid(1'b0),
        .sbiterr(NLW_U0_sbiterr_UNCONNECTED),
        .shutdown(1'b0),
        .sleep(1'b0),
        .wea(wea),
        .web(1'b0));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2021.2"
`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
oESHD2Q5NORrmTVTCApB+YFZJwjA1ezq7U6VZh96by+ofPCvSFp06AIoCLvB4BhPvxfob6kIkBpR
xVCOLM7HsDk7nO1JVWiYIJ6okoWTA8hAlPj3sdGuMwRlZNSBKn/c6F+CW5Jl37TEGotkhycSB3Bg
B/uu1THUZwIG87RPahE=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
RovEhaqHrFqzjckk+DIWG8LQeqg2Y/nACQDyXKKtSav7YHlgpKmgHZnsxwwNpqrqVRGyjTecSQ+e
6Mr/Pi9au3AgJVPL6VOgwNVE0yj2LpA4LPyWzxLN3+DiSDmsaCBNCBlVQi2MRKUabou8nLaXldbL
+7pv4pYhQdcyjDzuC2dx3HmzADqstdEiyXeU3ktJ29CDLDmGwDWdmsrl90s4YQSfBV2nj4/Vut3L
p/8dzphf1htPaNMujMxxgp3z4JzUEDJJokDL+gNutEEHiaWpI3URIA5v22vJu+NPD+eEraSioHfL
DPKAajZTwK5FHnonu4O2D0co8GWqWW5cUqZz9A==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
jBQ6Th9yy7jtKQD1h235YLT6qO6XiBaBKGJrV1Z8H9M9ePJ9R/fA8E1okt4LyBvoWjR7tmCbIg7A
0/vuKOogkLtDE/BtTlp4z1iurO8rQrAcdZy/e+7GATawyJxFY7kZhnXASu9zB8TiOBELSlapkpxe
WuAzXLde9FBMBkq4RSc=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
eucSNV2Zbm4zYc2tIGRlGmlVM8+WHY1NHe9drZdgDhGPOHz8PTqHapfnZ1kWuTLtPBLSMvcXNScn
UTvpULofBV6qD7WHLPg7UJcjpZVDL69lk88chgqrlc/RqaJXKNVv+Ubku53ZLU20uZK71bNymjSM
855RVWw5lvTHTCNC2MYIS94Fmrzuq8i0+tFh5qBKkHK2BC+fD7xVyyfuh4mZR2yr/hRs/emoI79E
IKoJnLiglVp6RXTsXFzZW4pIthbjWSuZlOQvoYkS2RMj8a0r9lyariphRQunoudc0bLO4Phk578c
40gusaaS/MI7idMT7k1Di96kvu5mHi23loRcZQ==

`pragma protect key_keyowner="Real Intent", key_keyname="RI-RSA-KEY-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
E/syLaRG2Ss/xTTkuAkOKXzm53+rCptYO2DkVukWhvlLmEB2daHCPrXt4gKeuG+0hIGWedSwCiLJ
7KNtEAiTumJ/j+3p7s3oXN9ftCSRolXoACsCclEAmwYjVM0ubCXUx6JNFOGt0yDl2Jsd5+W10mSJ
bYEKvRKi7koXM/eYJqbhTrtsrHDwRJEY0JVUPh8EOkLLqaIKbnjb6ENEY6qZOamp5PaWsSS30gJM
N6fB8D1AmGKnFbfY+d5TexS55Z92aYcAHNX2XwHsKnm45az1vHeZ0rTEU/oONIaSZfikRni1iDBg
x2GOue6sLiwxTEHaVkTJsOVR4mx0VsfFxavwRg==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2021_01", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
dSHHpkQiOEzzKs4D71WVyDXLpkKuR9h9h3pBLtnCq2bXiwE/eQHmk5HeQb+qREg0Yv193OukqaQz
RZyuF5GQcqOpqFHMxO62HQ2pdjdpMT5CC7gHvmgiw9qBkJJrXpihIHER4X7OF2iNUfeqxJ8eiSz3
C0V20NlIwKG7Mxg8MVj++xmb32KMUqL7ptikkym20vVdhecVMNvpPoXp8uvaGT7991enWP9HGKUC
9kLY2DEYwRGE71UJJLGWo4n49R50ExFRj91xWnYfvp7uJsMNwnBp5l3GTZiMELX2RkRVSPOHr7l1
n2p5Vq7Uee2drny1IxZ/4c0hYY6y3QWSEqpESw==

`pragma protect key_keyowner="Metrics Technologies Inc.", key_keyname="DSim", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
HUtfqZ9dh5oZTOAt9a0ebo+wQbzg3izFQ0kVqZN81S4cBjQEF53WUiVlTKBDVjvLNUby4Se9WZjj
j86TQzuGJxLPDTohmbytErsg5JrlXHbHGwR4zGNGTbBs12X7PkxtS8wVCp+7b1rX6pOGOPqm6FoG
g6rZY/bTzVfGYF2CAOhjJUqUOXEAKnZRehspRyiBI28/ZZPSAUD/abKprW8PWCxMx2zPWztZz4No
R96jgvHezNzB1Ta8W7uRBFTMp+XVSToxTp2jzSXJZ0V5xJl+gdVjAMmf6+te2vqrK2wDWdMxk3Sf
iyLI4d0s25vCybcY2fZWacq5iO9pSlSaOQWgCA==

`pragma protect key_keyowner="Atrenta", key_keyname="ATR-SG-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=384)
`pragma protect key_block
vYYu2Kvhv3RZi0pFbjRTQ/BBwfilCrGpkMls+Dz6HBGTZvSaC/anWgymoDS0XnoSENGG3Pz3EBF0
19OqLbyna95IHFe2bA7f8RgU9SEUffZ8eXGigfOjAWpZCN07Q77RkhGUKal7okWe3Q6xHtZy83l2
kW8ma3kOYL7GzQjtpbP3lINHLMqpGEo0dzbOHiJ5r6W5U6DsILGsoLQOXcw+MwrevvNRB0KkSklj
QnL8K2AK8PIsJGM6F8dj5KwRYhSBYNb1opuVpiJWlbHgADoeM+dhiRxBLmnaDE8PWs1ReY6uMzzH
SvvO6UEyxQtvS/Smm/uogr1eUFedUaBHPMEXnYlTAv/SKrh942GeknsqfrjGkZxWTN2NEnvpRUwT
fS0pyd/Err0s94b0srmcTYyxZfJGRUct2T8MCphZFaScAlhn655pxW9RaHMfcvDJUHpW8Qa+KhRt
9CWYScPIH6YNDByLQbhKL5BTpAYMNYPF2W7vM2ZzDob2NB7m6GGeKRr3

`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="CDS_RSA_KEY_VER_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
QSNmIeTT4pBji+CTjknWXN6sH9Wff8+t8KF+AC3fIoIw08jtLtShcB9ZGeEKG02RGCO4lNIUf5YB
2TVYk6EJ5XyCav12qDhc60n56UVrnpfo7drorY0NmOypuxECgO43h6SDWp9W7px3r4CJnQ4+X2Mj
943GdP30WfL5kbWHZJC1Dz9cBIqRa1EbNXvvAqBvRPS2+aXBXAPOC4rNVZGeIUspn/33IW3yJLSp
Jm5GIct87ZuSoz8+DXhUvsTj4hq8lgirVhfz1qhHm8SfODcE91FGUPw3vbpGWXsBX73t2zxFC1Hz
/6m4YqQJVxd+H5iGE4kbHxHyHnH7FIerqc8Phw==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
UhfxKxECbuHK/o9ZExa2zP/MIPmFXuDNZwgpiawuBmPeRI1nJsYB7vzbBGMPKny4yIHLT8mHrQRc
fs05atkjIAbLea4+WNoCdCeg7/0PzuodM1ol3it6BHQ6Yzq4mnZbzlk8Xtwmk8ACAbzOr2SYxYWX
ueuUlimUSRusIe4+NiPvzbfHMAOVPjdmSY7zaSyeJuhdAR+fUGeHy5B23Xe2X6cDPeJ75IqcBeul
ox3dTXi3L8r/s1bTKX3FhxRyPZuh/xCWuEajsF2fEYdwWHKtLX6IQniLBJ5ZnVSS8D7IYPsvV4t0
9rWJqto5O1n3rAM44OvKvc9pOYXJupuv7g3gWg==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
fmo66vhS7nigYtLDMjdj7hgUnDG/fnO+cIaY/3qHrcwT7u/paj5enLuWHovegu9O9WRq3pPNnjuN
6vZRpuCgz5p4VAV7dVg9fuzg99BAjThp1Q/+HIPfdQ2LM14ZpTh4FXxthHGkTyS5PJArvZ3/UMpW
zwfdYd5+k2/emJ4/nuqoJHQG8k+O5EjSprLTvNZ/wrE1cT/fW/Lu2pxI4msHqVVYAXz7sJ13cQ+C
7tKxCV8vTyf0rpStdE+kZXg+jrc7vFKuPJO0U9axMsC0nXyeYx2jzfAHptGWKvfQaPg/Eo9mgLyN
qSJfFS6aIycuxNmg7L82WK401aWhnUn7GNrudg==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 20464)
`pragma protect data_block
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
ew==
`pragma protect end_protected
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
