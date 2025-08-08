class fifo_wr_driver extends uvm_driver #(fifo_seq_item);
  `uvm_component_utils(fifo_wr_driver)
  virtual interface fifo_wrt_interface wr_vif;
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual task run_phase(uvm_phase phase);
    forever begin
      seq_item_port.get_next_item(req);
      if (!wr_vif.full) begin
        `uvm_info("DRV", $sformatf("Driving write: %h", req.wr_data), UVM_LOW)
        wr_vif.wr_en <= req.wr_en;
        wr_vif.wr_data <= req.wr_data;
        @(posedge wr_vif.clk_wr);
        wr_vif.wr_en <= 0;
      end else begin
        `uvm_info("DRV", "FIFO is full, stalling write.", UVM_LOW)
        @(posedge wr_vif.clk_wr);
      end
      seq_item_port.item_done();
    end
  endtask
endclass

class fifo_rd_driver extends uvm_driver #(fifo_seq_item);
  `uvm_component_utils(fifo_rd_driver)
  virtual interface fifo_read_interface rd_vif;
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual task run_phase(uvm_phase phase);
    forever begin
      seq_item_port.get_next_item(req);
      if (!rd_vif.empty) begin
        `uvm_info("DRV", "Driving read", UVM_LOW)
        rd_vif.rd_en <= req.rd_en;
        @(posedge rd_vif.clk_rd);
        rd_vif.rd_en <= 0;
      end else begin
        `uvm_info("DRV", "FIFO is empty, stalling read.", UVM_LOW)
        @(posedge rd_vif.clk_rd);
      end
      seq_item_port.item_done();
    end
  endtask
endclass