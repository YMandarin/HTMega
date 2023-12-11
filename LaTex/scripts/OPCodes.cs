﻿Dictionary<string, OpCode> OPCodes = new Dictionary<string, OpCode>()
{
    // special operations
    { "NOP",  new OpCode{ byteCode=0b00000000, param=Param.none }},
    { "END",  new OpCode{ byteCode=0b11111111, param=Param.none }},
    
    // data transfer
    { "MOV",  new OpCode{ byteCode=0b00100000, param=Param.reg_reg  }},
    { "LD",   new OpCode{ byteCode=0b00100010, param=Param.reg_ram  }},
    { "LDI",  new OpCode{ byteCode=0b00100100, param=Param.reg_imdt }},
    { "ILD",  new OpCode{ byteCode=0b00100110, param=Param.reg      }},
    { "ST",   new OpCode{ byteCode=0b00101000, param=Param.reg_ram  }},
    { "IST",  new OpCode{ byteCode=0b00101010, param=Param.reg      }},
    { "ISTI", new OpCode{ byteCode=0b00101100, param=Param.imdt     }},
    { "PUSH", new OpCode{ byteCode=0b00101110, param=Param.reg      }},
    { "PUSHI",new OpCode{ byteCode=0b00110000, param=Param.imdt     }},
    { "POP",  new OpCode{ byteCode=0b00110010, param=Param.reg      }},
    { "LPM",  new OpCode{ byteCode=0b00110100, param=Param.reg_pm   }},
    { "ILPM", new OpCode{ byteCode=0b00110110, param=Param.reg      }},
    { "SPM",  new OpCode{ byteCode=0b00111000, param=Param.reg_pm   }},
    { "ISPM", new OpCode{ byteCode=0b00111010, param=Param.reg      }},
    { "ISPMI",new OpCode{ byteCode=0b00111100, param=Param.imdt     }},

    // branching
    { "JMP",  new OpCode{ byteCode=0b01000000, param=Param.pm }},
    { "IJMP", new OpCode{ byteCode=0b01000010, param=Param.none }},
    { "JHI",  new OpCode{ byteCode=0b01000100, param=Param.pm }},
    { "JSLO", new OpCode{ byteCode=0b01000110, param=Param.pm }},
    { "JGE",  new OpCode{ byteCode=0b01001000, param=Param.pm }},
    { "JLT",  new OpCode{ byteCode=0b01001010, param=Param.pm }},

    { "JEQ",  new OpCode{ byteCode=0b01100000, param=Param.pm }},
    { "JNEQ", new OpCode{ byteCode=0b01100010, param=Param.pm }},
    { "JSHI", new OpCode{ byteCode=0b01100110, param=Param.pm }},
    { "JLO",  new OpCode{ byteCode=0b01100100, param=Param.pm }},
    { "JMI",  new OpCode{ byteCode=0b01101000, param=Param.pm }},
    { "JPL",  new OpCode{ byteCode=0b01101010, param=Param.pm }},

    { "RJMP",  new OpCode{ byteCode=0b01000001, param=Param.pm }},
    { "RIJMP", new OpCode{ byteCode=0b01000011, param=Param.none }},
    { "RJHI",  new OpCode{ byteCode=0b01000101, param=Param.pm }},
    { "RJSLO", new OpCode{ byteCode=0b01000111, param=Param.pm }},
    { "RJGE",  new OpCode{ byteCode=0b01001001, param=Param.pm }},
    { "RJLT",  new OpCode{ byteCode=0b01001011, param=Param.pm }},

    { "RJEQ",  new OpCode{ byteCode=0b01100001, param=Param.pm }},
    { "RJNEQ", new OpCode{ byteCode=0b01100011, param=Param.pm }},
    { "RJSHI", new OpCode{ byteCode=0b01100111, param=Param.pm }},
    { "RJLO",  new OpCode{ byteCode=0b01100101, param=Param.pm }},
    { "RJMI",  new OpCode{ byteCode=0b01101001, param=Param.pm }},
    { "RJPL",  new OpCode{ byteCode=0b01101011, param=Param.pm }},

    // branch by flag                                          
    { "JFZS", new OpCode{ byteCode=0b01100000, param=Param.pm }},
    { "JFCS", new OpCode{ byteCode=0b01100100, param=Param.pm }},
    { "JFNS", new OpCode{ byteCode=0b01101000, param=Param.pm }},
    { "JFVS", new OpCode{ byteCode=0b01101100, param=Param.pm }},
    { "JFTS", new OpCode{ byteCode=0b01110000, param=Param.pm }},
    { "JFIS", new OpCode{ byteCode=0b01110100, param=Param.pm }},
    { "JFRS", new OpCode{ byteCode=0b01111000, param=Param.pm }},
    { "JFPS", new OpCode{ byteCode=0b01111100, param=Param.pm }},

    { "JFZC", new OpCode{ byteCode=0b01100010, param=Param.pm }},
    { "JFCC", new OpCode{ byteCode=0b01100110, param=Param.pm }},
    { "JFNC", new OpCode{ byteCode=0b01101010, param=Param.pm }},
    { "JFVC", new OpCode{ byteCode=0b01101110, param=Param.pm }},
    { "JFTC", new OpCode{ byteCode=0b01110010, param=Param.pm }},
    { "JFIC", new OpCode{ byteCode=0b01110110, param=Param.pm }},
    { "JFRC", new OpCode{ byteCode=0b01111010, param=Param.pm }},
    { "JFPC", new OpCode{ byteCode=0b01111110, param=Param.pm }},

    { "RJFZS", new OpCode{ byteCode=0b01100001, param=Param.pm }},
    { "RJFCS", new OpCode{ byteCode=0b01100101, param=Param.pm }},
    { "RJFNS", new OpCode{ byteCode=0b01101001, param=Param.pm }},
    { "RJFVS", new OpCode{ byteCode=0b01101101, param=Param.pm }},
    { "RJFTS", new OpCode{ byteCode=0b01110001, param=Param.pm }},
    { "RJFIS", new OpCode{ byteCode=0b01110101, param=Param.pm }},
    { "RJFRS", new OpCode{ byteCode=0b01111001, param=Param.pm }},
    { "RJFPS", new OpCode{ byteCode=0b01111101, param=Param.pm }},

    { "RJFZC", new OpCode{ byteCode=0b01100011, param=Param.pm }},
    { "RJFCC", new OpCode{ byteCode=0b01100111, param=Param.pm }},
    { "RJFNC", new OpCode{ byteCode=0b01101011, param=Param.pm }},
    { "RJFVC", new OpCode{ byteCode=0b01101111, param=Param.pm }},
    { "RJFTC", new OpCode{ byteCode=0b01110011, param=Param.pm }},
    { "RJFIC", new OpCode{ byteCode=0b01110111, param=Param.pm }},
    { "RJFRC", new OpCode{ byteCode=0b01111011, param=Param.pm }},
    { "RJFPC", new OpCode{ byteCode=0b01111111, param=Param.pm }},

    // double arithmetics
    { "ADD",  new OpCode{ byteCode=0b10000000, param=Param.reg_reg }},
    { "ADDC", new OpCode{ byteCode=0b10000010, param=Param.reg_reg }},
    { "SUB",  new OpCode{ byteCode=0b10000100, param=Param.reg_reg }},
    { "SUBC", new OpCode{ byteCode=0b10000110, param=Param.reg_reg }},
    { "MUL",  new OpCode{ byteCode=0b10001000, param=Param.reg_reg }},
    { "DIV",  new OpCode{ byteCode=0b10001010, param=Param.reg_reg }},
    { "MULS", new OpCode{ byteCode=0b10001100, param=Param.reg_reg }},
    { "DIVS", new OpCode{ byteCode=0b10001110, param=Param.reg_reg }},
    { "AND",  new OpCode{ byteCode=0b10010000, param=Param.reg_reg }},
    { "OR",   new OpCode{ byteCode=0b10010010, param=Param.reg_reg }},
    { "XOR",  new OpCode{ byteCode=0b10010100, param=Param.reg_reg }},
    { "CP",   new OpCode{ byteCode=0b10010110, param=Param.reg_reg }},
    { "CPC",  new OpCode{ byteCode=0b10011000, param=Param.reg_reg }},    
    { "BTST", new OpCode{ byteCode=0b10011010, param=Param.reg_reg }},


    { "ADDI", new OpCode{ byteCode=0b10000001, param=Param.reg_imdt }},
    { "ADDCI",new OpCode{ byteCode=0b10000011, param=Param.reg_imdt }},
    { "SUBI", new OpCode{ byteCode=0b10000101, param=Param.reg_imdt }},
    { "SUBCI",new OpCode{ byteCode=0b10000111, param=Param.reg_imdt }},
    { "MULI", new OpCode{ byteCode=0b10001001, param=Param.reg_imdt }},
    { "DIVI", new OpCode{ byteCode=0b10001011, param=Param.reg_imdt }},
    { "MULSI",new OpCode{ byteCode=0b10001101, param=Param.reg_imdt }},
    { "DIVSI",new OpCode{ byteCode=0b10001111, param=Param.reg_imdt }},
    { "ANDI", new OpCode{ byteCode=0b10010001, param=Param.reg_imdt }},
    { "ORI",  new OpCode{ byteCode=0b10010011, param=Param.reg_imdt }},
    { "XORI", new OpCode{ byteCode=0b10010101, param=Param.reg_imdt }},
    { "CPI",  new OpCode{ byteCode=0b10010111, param=Param.reg_imdt }},
    { "CPCI", new OpCode{ byteCode=0b10011001, param=Param.reg_imdt }},
    { "BTSTI",new OpCode{ byteCode=0b10011011, param=Param.reg_imdt }},

    // single arithmetics
    { "IS",  new OpCode{ byteCode=0b10100000, param=Param.reg }},
    { "COM", new OpCode{ byteCode=0b10100010, param=Param.reg }},
    { "NEG", new OpCode{ byteCode=0b10100100, param=Param.reg }},
    { "INC", new OpCode{ byteCode=0b10100110, param=Param.reg }},
    { "DEC", new OpCode{ byteCode=0b10101000, param=Param.reg }},
    { "SWAP",new OpCode{ byteCode=0b10101010, param=Param.reg }},
    { "LSL", new OpCode{ byteCode=0b10101100, param=Param.reg }},
    { "LSR", new OpCode{ byteCode=0b10101110, param=Param.reg }},
    { "ROL", new OpCode{ byteCode=0b10110000, param=Param.reg }},
    { "ROR", new OpCode{ byteCode=0b10110010, param=Param.reg }},
    { "ASR", new OpCode{ byteCode=0b10110100, param=Param.reg }},
    { "TST", new OpCode{ byteCode=0b10110110, param=Param.reg }}
 };