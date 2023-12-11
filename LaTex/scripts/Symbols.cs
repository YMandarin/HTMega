Dictionary<string, string> RegSymbols = new Dictionary<string, string>()
{
    // GPIO Registers
    {"PA_IN",  "0xE2" },
    {"PA_OUT", "0xE3" },
    {"PA_CONF","0xE4" },
    {"PB_IN",  "0xE5" },
    {"PB_OUT", "0xE6" },
    {"PB_CONF","0xE7" },
    {"PC_IN",  "0xE8" },
    {"PC_OUT", "0xE9" },
    {"PC_CONF","0xEA" },
    {"PD_IN",  "0xEB" },
    {"PD_OUT", "0xEC" },
    {"PD_CONF","0xED" },

    // UART Registers
    {"UART_CONF","0xEE" },
    {"UART_TD",  "0xEF" },
    {"UART_RD",  "0xF0" },

    // Timer Registers
    {"TIMA_VAL", "0xF1" },
    {"TIMB_VAL", "0xF2" },
    {"TIMA_TOP", "0xF3" },
    {"TIMB_TOP", "0xF4" },
    {"TIMA_COMP","0xF5" },
    {"TIMB_COMP","0xF6" },
    {"TIMA_CONF","0xF7" },
    {"TIMB_CONF","0xF8" },
    {"MICR_L",   "0xF9" },
    {"MICR_H",   "0xFA" },

    // Special Registers
    {"ALU_B", "0xFB" },
    {"SP",    "0xFC" },
    {"IADDR", "0xFD" },
    {"PC",    "0xFE" },
    {"FLAGS", "0xFF" }
};