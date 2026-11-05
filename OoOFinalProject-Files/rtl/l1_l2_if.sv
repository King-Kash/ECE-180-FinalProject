// L1 L2 Interface

interface l1_l2_if
    import cache_pkg::*;
();
    // producer signals
    logic request_valid;
    line_addr request_line_addr;
    logic response_ready;
    logic victim_valid;
    line_addr victim_line_addr;
    line_data victim_line_data;
    logic victim_dirty;
    logic victim_reused;

    // consumer signals
    logic request_ready;
    logic response_valid;
    line_data response_line_data;
    logic response_dirty;
    logic response_error;
    logic resp_from_l2;

    modport l1 (
        output request_valid,
        output request_line_addr,
        output response_ready,
        output victim_valid,
        output victim_line_addr,
        output victim_line_data,
        output victim_dirty,
        output victim_reused,

        input request_ready,
        input response_valid,
        input response_line_data,
        input response_dirty,
        input response_error,
        input resp_from_l2
    );

    modport l2 (
        input request_valid,
        input request_line_addr,
        input response_ready,
        input victim_line_valid,
        input victim_line_addr,
        input victim_line_data,
        input victim_dirty,
        input victim_reused

        output request_ready,
        output response_valid,
        output response_line_data,
        output response_dirty,
        output response_error,
        output resp_from_l2
    );

endinterface

/*

L1 → L2 (Out)
- Request_valid (1 bit)
- Request_line_address (28 bits)
- Response_ready (1 bit)
- Victim_valid (1 bit) : 1 if L1 is sending a victim line 0 if it is not
- Victim_line_address (28 bits)
- Victim_data (128 bits) 
- Victim_dirty (1 bit)
- Victim_reused (1 bit) : Tracks if a line brought up from L2 was used by L1. This is important because BRRIP will default inserts to RRPV of 3 or 2. However when the line was brought up from L2 there was no way to update its RRPV to 0 because it was removed from the L2 cache. This verifies that it was used in L1 and when it goes back to L2 it will get a RRPV of 0.


L1 → L2 (In)
- Request_ready (1 bit)
- Response_valid (1 bit)
- Response_data (128 bits) : 
- Response_dirty (1 bit)
- Response_error (1 bit)



*/