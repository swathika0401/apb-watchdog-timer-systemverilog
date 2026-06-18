class environment;

    mailbox gen2drv=new();
    mailbox mon2scb=new();
    mailbox wdt2scb=new();
    mailbox ref_in=new();
    mailbox ref_out=new();

    apb_generator gen;
    apb_driver drv;
    apb_monitor mon;
    wdt_monitor wmon;
    wdt_generator wgen;
    ref_model refm;
    scoreboard scb;
    wdt_driver wdrv;

    virtual apb_if apb_vif;
    virtual wdt_if wdt_vif;

    function new(virtual apb_if a, virtual wdt_if w);
        apb_vif=a; wdt_vif=w;

        gen=new(gen2drv);
        drv=new(gen2drv); drv.vif=a;
        mon=new(mon2scb); mon.vif=a;

        wgen=new(ref_in);
        wmon=new(wdt2scb); wmon.vif=w;

        refm=new(ref_in,ref_out);
        scb=new(ref_out,wdt2scb);

        wdrv=new(); wdrv.vif=w;
    endfunction

    task run();
        fork
            gen.run();
            drv.run();
            mon.run();
            wgen.run();
            wmon.run();
            refm.run();
            scb.run();
            wdrv.run();
        join_none
    endtask
endclass
