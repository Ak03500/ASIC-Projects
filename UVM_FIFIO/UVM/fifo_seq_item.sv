class fifo_seq_item extends uvm_sequence_item;
  `uvm_object_utils_begin(fifo_seq_item)
    `uvm_field_int(wr_data, UVM_ALL_ON)
    `uvm_field_int(rd_data, UVM_ALL_ON)
    `uvm_field_int(wr_en, UVM_ALL_ON)
    `uvm_field_int(rd_en, UVM_ALL_ON)
  `uvm_object_utils_end

  rand logic [7:0] wr_data;
  logic [7:0]      rd_data;
  rand logic       wr_en;
  rand logic       rd_en;

  function new(string name = "fifo_seq_item");
    super.new(name);
  endfunction
endclass