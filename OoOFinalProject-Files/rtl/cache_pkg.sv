// L1 L2 Cache parameters

package cache_pkg;

    import rv32_ooo_pkg::XLEN;

    localparam int ADDR_W = XLEN;
    localparam int DATA_W = XLEN; 
    localparam int BLOCK_BYTES = 16;

    // L1_L2 Interface Dimensions
    localparam int unsigned LINE_BIT_COUNT = 128;
    localparam int unsigned LINE_ADDR_LEN = 28;

    typedef logic [LINE_BIT_COUNT-1:0] line_data;
    typedef logic [LINE_ADDR_LEN-1:0] line_addr;

    localparam int WORD_BYTES = DATA_W / 8; // 4
    localparam int WORDS_PER_BLOCK = BLOCK_BYTES / WORD_BYTES; 
    localparam int BLOCK_W = BLOCK_BYTES * 8; //
    
    localparam int BYTE_OFF_W = $clog2(WORD_BYTES);
    localparam int WORD_OFF_W = $clog2(WORDS_PER_BLOCK); 
    localparam int BLOCK_OFF_W = BYTE_OFF_W + WORD_OFF_W; 
    
    // L1 dimensions
    localparam int L1_SIZE_BYTES = 4 * 1024; // 4k
    localparam int L1_WAYS = 4;
    localparam int L1_SETS = L1_SIZE_BYTES / (BLOCK_BYTES * L1_WAYS); 
    localparam int L1_INDEX_W = $clog2(L1_SETS);
    localparam int L1_TAG_W = ADDR_W - L1_INDEX_W - BLOCK_OFF_W; 
    localparam int L1_WAY_W = $clog2(L1_WAYS); 
    localparam int L1_PLRU_W = L1_WAYS - 1;
    
    // L2 dimensions
    localparam int L2_SIZE_BYTES = 16 * 1024; //16k
    localparam int L2_WAYS       = 8;
    localparam int L2_SETS    = L2_SIZE_BYTES / (BLOCK_BYTES * L2_WAYS); 
    localparam int L2_INDEX_W = $clog2(L2_SETS); 
    localparam int L2_TAG_W   = ADDR_W - L2_INDEX_W - BLOCK_OFF_W; 
    localparam int L2_WAY_W   = $clog2(L2_WAYS); 

    // L2 BRRIP
    localparam int RRPV_W        = 2;
    localparam int RRPV_MAX      = 3;
    localparam int BIP_THROTTLE  = 32;   // 1-in-32 insert at RRPV 2
    localparam int BIP_CNT_W     = $clog2(BIP_THROTTLE); // used for the counter implimentation of 1 in 32 chance of getting a 2


endpackage