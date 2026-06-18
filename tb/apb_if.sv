interface apb_if;
    logic PCLK, PRESETn;
    logic PSEL, PENABLE, PWRITE;
    logic [7:0] PADDR;
    logic [31:0] PWDATA;
endinterface
