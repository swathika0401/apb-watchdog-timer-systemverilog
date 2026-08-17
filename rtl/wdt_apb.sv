module wdt_apb (
    input  logic PCLK,
    input  logic PRESETn,

    input  logic PSEL,
    input  logic PENABLE,
    input  logic PWRITE,
    input  logic [7:0] PADDR,
    input  logic [31:0] PWDATA,
    output logic [31:0] PRDATA,

    input  logic WDOGCLK,
    input  logic WDOGCLKEN,

    output logic WDOGINT,
    output logic WDOGRES
);

    logic [31:0] load;
    logic [31:0] counter;

    logic INTEN;
    logic RESEN;
    logic clear_req;

    // APB registers
    always_ff @(posedge PCLK or negedge PRESETn) begin

        if (!PRESETn) begin
            load      <= 32'hFFFFFFFF;
            INTEN     <= 1'b0;
            RESEN     <= 1'b0;
            clear_req <= 1'b0;
        end

        else begin

            clear_req <= 1'b0;

            if (PSEL && PENABLE && PWRITE) begin

                case (PADDR)

                    // LOAD register
                    8'h00:
                        load <= PWDATA;

                    // CONTROL register
                    8'h04: begin
                        INTEN <= PWDATA[0];
                        RESEN <= PWDATA[1];
                    end

                    // CLEAR / REFRESH register
                    8'h0C:
                        clear_req <= 1'b1;

                endcase

            end

        end

    end


    // APB read
    always_comb begin

        case (PADDR)

            8'h00:
                PRDATA = load;

            8'h08:
                PRDATA = counter;

            default:
                PRDATA = 32'h0;

        endcase

    end


    // Watchdog
    always_ff @(posedge WDOGCLK or negedge PRESETn) begin

        if (!PRESETn) begin

            counter <= 32'hFFFFFFFF;
            WDOGINT <= 1'b0;
            WDOGRES <= 1'b0;

        end

        else if (WDOGCLKEN && INTEN) begin

            // Refresh
            if (clear_req) begin

                counter <= load;
                WDOGINT <= 1'b0;
                WDOGRES <= 1'b0;

            end

            // Timeout
            else if (counter == 0) begin

                if (!WDOGINT)
                    WDOGINT <= 1'b1;

                else if (RESEN)
                    WDOGRES <= 1'b1;

                counter <= load;

            end

            else begin

                counter <= counter - 1'b1;

            end

        end

    end

endmodule
