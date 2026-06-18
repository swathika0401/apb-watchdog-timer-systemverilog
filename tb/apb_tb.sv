`include "apb_if.sv"
`include "wdt_if.sv"
`include "apb_txn.sv"
`include "wdt_txn.sv"
`include "apb_generator.sv"
`include "wdt_generator.sv"
`include "apb_driver.sv" 
`include "wdt_driver.sv"
`include "apb_monitor.sv"
`include "wdt_monitor.sv"
`include "ref_model.sv"
`include "scoreboard.sv" 
`include "environment.sv"
`include "test.sv" 

module top;

    apb_if apb();
    wdt_if wdt();

    wdt_apb dut(
        .PCLK(apb.PCLK),
        .PRESETn(apb.PRESETn),
        .PSEL(apb.PSEL),
        .PENABLE(apb.PENABLE),
        .PWRITE(apb.PWRITE),
        .PADDR(apb.PADDR),
        .PWDATA(apb.PWDATA),
        .PRDATA(),
        .WDOGCLK(wdt.WDOGCLK),
        .WDOGCLKEN(wdt.WDOGCLKEN),
        .WDOGINT(wdt.WDOGINT),
        .WDOGRES(wdt.WDOGRES)
    );

    environment env;
    test t;

    always #5 apb.PCLK = ~apb.PCLK;
    always #10 wdt.WDOGCLK = ~wdt.WDOGCLK;

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0,top);

        apb.PCLK=0; wdt.WDOGCLK=0;
        apb.PRESETn=0; wdt.WDOGCLKEN=1;

        #20 apb.PRESETn=1;

        env=new(apb,wdt);
        t=new(env);

        t.run();

        #500 $finish;
    end
endmodule
