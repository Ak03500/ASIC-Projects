class fifo_base_test extends uvm_test;
  `uvm_component_utils(fifo_base_test)
  fifo_env m_env;
  fifo_virtual_sequence m_v_seq;
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
  virtual function void build_phase(uvm_phase phase);
    m_env = fifo_env::type_id::create("m_env", this);
  endfunction
  virtual task run_phase(uvm_phase phase);
    m_v_seq = fifo_virtual_sequence::type_id::create("m_v_seq");
    phase.raise_objection(this);
    m_v_seq.start(null);
    phase.drop_objection(this);
  endtask
endclass