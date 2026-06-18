module wdt_apb (
    input logic PCLK, PRESETn,
    input logic PSEL, PENABLE, PWRITE,
    input logic [7:0] PADDR,
    input logic [31:0] PWDATA,
    output logic [31:0] PRDATA,

    input logic WDOGCLK, WDOGCLKEN,
    output logic WDOGINT, WDOGRES
);

    logic [31:0] load, counter;
    logic INTEN, RESEN, clear_req;

    always_ff @(posedge PCLK or negedge PRESETn) begin
        if (!PRESETn) begin
            load <= 32'hFFFFFFFF;
            INTEN <= 0; RESEN <= 0; clear_req <= 0;
        end else begin
            clear_req <= 0;
            if (PSEL && PENABLE && PWRITE) begin
                case (PADDR)
                    8'h00: load <= PWDATA;
                    8'h04: begin INTEN <= PWDATA[0]; RESEN <= PWDATA[1]; end
                    8'h0C: clear_req <= 1;
                endcase
            end
        end
    end

    always_comb begin
        case (PADDR)
            8'h00: PRDATA = load;
            8'h08: PRDATA = counter;
            default: PRDATA = 0;
        endcase
    end

    always_ff @(posedge WDOGCLK or negedge PRESETn) begin
        if (!PRESETn) begin
            counter <= 32'hFFFFFFFF;
            WDOGINT <= 0;
            WDOGRES <= 0;
        end else if (WDOGCLKEN && INTEN) begin
            if (clear_req) begin
                counter <= load;
                WDOGINT <= 0;
            end else if (counter == 0) begin
                if (!WDOGINT) WDOGINT <= 1;
                else if (RESEN) WDOGRES <= 1;
                counter <= load;
            end else counter <= counter - 1;
        end
    end
endmodule
