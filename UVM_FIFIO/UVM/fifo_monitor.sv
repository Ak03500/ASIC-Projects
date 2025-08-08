class fifo_wr_monitor extends uvm_monitor;
  `uvm_component_utils(fifo_wr_monitor)
  virtual interface fifo_wrt_interface wr_vif;
  uvm_analysis_port #(fifo_seq_item) wr_ap;
  function new(string name, uvm_component parent);
    super.new(name, parent);
    wr_ap = new("wr_ap", this);
  endfunction

  virtual task run_phase(uvm_phase phase);
    forever begin
      @(posedge wr_vif.clk_wr);
      if (wr_vif.wr_en && !wr_vif.full) begin
        fifo_seq_item tx = fifo_seq_item::type_id::create("tx");
        tx.wr_data = wr_vif.wr_data;
        `uvm_info("MON", $sformatf("Monitored write: %h", tx.wr_data), UVM_LOW)
        wr_ap.write(tx);
      end
    end
  endtask
endclass

class fifo_rd_monitor extends uvm_monitor;
  `uvm_component_utils(fifo_rd_monitor)
  virtual interface fifo_read_interface rd_vif;
  uvm_analysis_port #(fifo_seq_item) rd_ap;
  function new(string name, uvm_component parent);
    super.new(name, parent);
    rd_ap = new("rd_ap", this);
  endfunction

  virtual task run_phase(uvm_phase phase);
    forever begin
      @(posedge rd_vif.clk_rd);
      if (rd_vif.rd_en && !rd_vif.empty) begin
        fifo_seq_item tx = fifo_seq_item::type_id::create("tx");
        tx.rd_data = rd_vif.rd_data;
        `uvm_info("MON", $sformatf("Monitored read: %h", tx.rd_data), UVM_LOW)
        rd_ap.write(tx);
      end
    end
  endtask
endclass