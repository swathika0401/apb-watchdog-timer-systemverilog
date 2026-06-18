class test;
    environment env;

    function new(environment e);
        env = e;
    endfunction

    task run();
        env.run();
    endtask
endclass
