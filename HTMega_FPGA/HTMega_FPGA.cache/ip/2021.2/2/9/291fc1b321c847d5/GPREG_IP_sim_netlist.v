// Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2021.2 (win64) Build 3367213 Tue Oct 19 02:48:09 MDT 2021
// Date        : Sat Feb 12 20:46:00 2022
// Host        : YMLap running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ GPREG_IP_sim_netlist.v
// Design      : GPREG_IP
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "GPREG_IP,blk_mem_gen_v8_4_5,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_5,Vivado 2021.2" *) 
(* NotValidForBitStream *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix
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
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_blk_mem_gen_v8_4_5 U0
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
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 20544)
`pragma protect data_block
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
jy95DYUwHrfrkFxw7eXkPPP9PQNpnuQ/
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
