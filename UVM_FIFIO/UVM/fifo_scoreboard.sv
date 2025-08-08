class fifo_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(fifo_scoreboard)
  uvm_tlm_analysis_fifo #(fifo_seq_item) wr_fifo;
  uvm_tlm_analysis_fifo #(fifo_seq_item) rd_fifo;
  uvm_tlm_fifo #(fifo_seq_item) golden_fifo;
  function new(string name, uvm_component parent);
    super.new(name, parent);
    wr_fifo = new("wr_fifo", this);
    rd_fifo = new("rd_fifo", this);
    golden_fifo = new("golden_fifo", this);
  endfunction

  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
  endfunction

  virtual task run_phase(uvm_phase phase);
    forever begin
      fifo_seq_item wr_item;
      fifo_seq_item rd_item;

      wr_fifo.get(wr_item);

      golden_fifo.put(wr_item);

      rd_fifo.get(rd_item);

      golden_fifo.get(wr_item);

      if (rd_item.rd_data == wr_item.wr_data) begin
        `uvm_info("SCB", "Data matched.", UVM_LOW)
      end else begin
        `uvm_error("SCB", $sformatf("Data mismatch! Got %h, expected %h.", rd_item.rd_data, wr_item.wr_data))
      end
    end
  endtask
endclass    