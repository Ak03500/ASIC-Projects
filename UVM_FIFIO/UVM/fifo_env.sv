class fifo_env extends uvm_env;
  `uvm_component_utils(fifo_env)
  fifo_wr_agent m_wr_agent;
  fifo_rd_agent m_rd_agent;
  fifo_scoreboard m_scb;
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
  virtual function void build_phase(uvm_phase phase);
    m_wr_agent = fifo_wr_agent::type_id::create("m_wr_agent", this);
    m_rd_agent = fifo_rd_agent::type_id::create("m_rd_agent", this);
    m_scb      = fifo_scoreboard::type_id::create("m_scb", this);
  endfunction
  virtual function void connect_phase(uvm_phase phase);
    m_wr_agent.m_mon.wr_ap.connect(m_scb.wr_fifo.analysis_export);
    m_rd_agent.m_mon.rd_ap.connect(m_scb.rd_fifo.analysis_export);
  endfunction
endclass