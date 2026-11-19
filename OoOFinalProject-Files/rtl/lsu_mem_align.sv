module lsu_mem_align
    import rv32_ooo_pkg::*;
(
    input logic [31:0] addr,
    input mem_size_e size, 
    input logic [31:0] store_data,

    output logic [31:0] word_addr,
    output logic [3:0] byte_en,
    output logic [31:0] wdata,
    output logic misaligned
);

    logic [1:0] offset;
    assign offset = addr[1:0];
    assign word_addr = {addr[31:2], 2'b00};

    always_comb begin
        byte_en = 4'b0000;
        wdata = store_data;
        misaligned = 1'b0;

        case(size)
            MEM_BYTE: begin // byte offset
                byte_en = 4'b0001 << offset;
                wdata = {4{store_data[7:0]}}
            end
            MEM_HALF: begin
                misaligned = offset[0];
                byte_en = offset[1] ? 4'b1100 : 4'b0011;
                wdata = {2{store_data[15:0]}};
            end
            MEM_WORD: begin 
                misaligned = |offset;
                byte_en = 4'b1111;
            end
            default: byte_en = 4'b0000;            // decoder should never send this
        endcase

        // A misaligned access must never write anything.
        if (misaligned) byte_en = 4'b0000;
    end

endmodule