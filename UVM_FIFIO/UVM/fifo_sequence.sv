class fifo_base_sequence extends uvm_sequence #(fifo_seq_item);
  `uvm_object_utils(fifo_base_sequence)
  function new(string name = "fifo_base_sequence");
    super.new(name);
  endfunction
endclass

class fifo_wr_sequence extends fifo_base_sequence;
  `uvm_object_utils(fifo_wr_sequence)
  function new(string name = "fifo_wr_sequence");
    super.new(name);
  endfunction
  virtual task body();
    repeat(10) begin
      req = fifo_seq_item::type_id::create("req");
      start_item(req);
      req.randomize();
      finish_item(req);
    end
  endtask
endclass

class fifo_rd_sequence extends fifo_base_sequence;
  `uvm_object_utils(fifo_rd_sequence)
  function new(string name = "fifo_rd_sequence");
    super.new(name);
  endfunction
  virtual task body();
    repeat(10) begin
      req = fifo_seq_item::type_id::create("req");
      start_item(req);
      req.randomize();
      finish_item(req);
    end
  endtask
endclass

class fifo_virtual_sequence extends uvm_sequence;
  `uvm_object_utils(fifo_virtual_sequence)
  fifo_wr_sequence wr_seq;
  fifo_rd_sequence rd_seq;
  function new(string name = "fifo_virtual_sequence");
    super.new(name);
    wr_seq = fifo_wr_sequence::type_id::create("wr_seq");
    rd_seq = fifo_rd_sequence::type_id::create("rd_seq");
  endfunction
  virtual task body();
    fork
      wr_seq.start(p_sequencer.m_wr_agent.m_sqr);
      rd_seq.start(p_sequencer.m_rd_agent.m_sqr);
    join
  endtask
endclass