class fifo_wr_sequencer extends uvm_sequencer #(fifo_seq_item);
  `uvm_component_utils(fifo_wr_sequencer)
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
endclass

class fifo_rd_sequencer extends uvm_sequencer #(fifo_seq_item);
  `uvm_component_utils(fifo_rd_sequencer)
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
endclass