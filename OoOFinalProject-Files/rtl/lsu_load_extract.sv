module lsu_load_extract 
    import rv32_ooo_pkg::*;
(
    input logic [31:0] word,
    input logic [1:0] offset,
    input mem_size_e size,
    input logic load_unsigned,
    output logic [31:0] result
);

    logic [31:0] shifted;
    assign shifted = word >> {offset, 3'b000};

    always_comb begin
        case(size)
            MEM_BYTE: result = load_unsigned ? {24'b0, shifted[7:0]} : {{24{shifted[7]}}, shifted[7:0]};
            MEM_HALF: result = load_unsigned ? {16'b0, shifted[15:0]} : {{16{shifted[15]}}, shifted[15:0]};

            default: result = word;

        endcase

    end

endmodule