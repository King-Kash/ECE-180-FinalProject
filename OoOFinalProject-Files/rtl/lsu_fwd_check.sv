module lsu_fwd_check (
    input logic [31:0] ld_word_addr,
    input logic [3:0] ld_byte_en,
    input logic [31:0] st_word_addr,
    input logic [3:0] st_byte_en,
    input logic st_addr_valid,

    output logic match,
    output logic full_cover

)

    logic same_word;
    assign same_word = st_addr_valid && (ld_word_addr[31:2] == st_word_addr[31:2]);
    assign match = same_word && | (st_byte_en & ld_byte_en);
    assign full_cover = match && ((st_byte_en & ld_byte_en) == ld_byte_en);

endmodule