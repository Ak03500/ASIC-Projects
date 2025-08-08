class fifo_wr_agent extends uvm_agent;
  `uvm_component_utils(fifo_wr_agent)
  fifo_wr_sequencer m_sqr;
  fifo_wr_driver    m_drv;
  fifo_wr_monitor   m_mon;
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
  virtual function void build_phase(uvm_phase phase);
    m_mon = fifo_wr_monitor::type_id::create("m_mon", this);
    if (get_is_active() == UVM_ACTIVE) begin
      m_sqr = fifo_wr_sequencer::type_id::create("m_sqr", this);
      m_drv = fifo_wr_driver::type_id::create("m_drv", this);
    end
  endfunction
  virtual function void connect_phase(uvm_phase phase);
    if (get_is_active() == UVM_ACTIVE) begin
      m_drv.seq_item_port.connect(m_sqr.seq_item_export);
    end
  endfunction
endclass

class fifo_rd_agent extends uvm_agent;
  `uvm_component_utils(fifo_rd_agent)
  fifo_rd_sequencer m_sqr;
  fifo_rd_driver    m_drv;
  fifo_rd_monitor   m_mon;
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
  virtual function void build_phase(uvm_phase phase);
    m_mon = fifo_rd_monitor::type_id::create("m_mon", this);
    if (get_is_active() == UVM_ACTIVE) begin
      m_sqr = fifo_rd_sequencer::type_id::create("m_sqr", this);
      m_drv = fifo_rd_driver::type_id::create("m_drv", this);
    end
  endfunction
  virtual function void connect_phase(uvm_phase phase);
    if (get_is_active() == UVM_ACTIVE) begin
      m_drv.seq_item_port.connect(m_sqr.seq_item_export);
    end
  endfunction
endclass