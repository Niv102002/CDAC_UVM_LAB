`uvm_analysis_imp_decl(_mon)
`uvm_analysis_imp_decl(_drv)

class sb extends uvm_scoreboard ;

  uvm_analysis_imp_mon #(usequence_item, sb) export_mon;
  uvm_analysis_imp_drv #(usequence_item, sb) eport_drv;
  
  usequence_item seq_mon_q[$];
  usequence_item seq_drv_q[$];

  usequence_item seq_mon;
  usequence_item seq_drv;

  event monitor_trigger;
  event driver_trigger;

  static int seq_count;
  static int seq_count_drv;
  static int seq_count_mon;

  `uvm_component_utils(sb)

  function new(string name = "sb", uvm_component parent=null);
    super.new(name, parent);
    export_mon = new("export_mon", this);
    eport_drv = new("eport_drv", this);
    this.seq_count = 0;
    this.seq_count_drv = 0;
    this.seq_count_mon = 0;
  endfunction


  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info(get_type_name(), " BUILD PHASE OF SCOREBOARD ", UVM_HIGH)
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    /**** Write body of this function ****/
  endfunction

  // end_of_elaboration
  function void end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);
    /**** Write body of this function ****/
  endfunction

  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    forever begin
      #1;
      // @(monitor_trigger);
      // @(driver_trigger);
      wait(seq_mon_q.size() > 0);
      seq_mon = seq_mon_q.pop_front();
      wait(seq_drv_q.size() > 0);
      seq_drv = seq_drv_q.pop_front();

      // if(seq_mon.compare(seq_drv)) begin
      //     `uvm_info(get_type_name(),$sformatf("compare match"),UVM_HIGH)
      // end else begin
      //     `uvm_info(get_type_name(),$sformatf("compare not match"),UVM_HIGH)
      // end

      // Based on control signals, we can decide whether to addition or subtraction
      if(seq_drv.en_in) begin
        if(seq_drv.control_in) begin
          // seq_drv.print();
          seq_mon.print();
          if (seq_mon.y_out == (seq_drv.data1 + seq_drv.data2)) begin
            // `uvm_info("", $sformatf("mon y_out : %0d  drv_data 1 : %0d drv_data 2 : %0d", seq_mon.y_out, seq_drv.data1, seq_drv.data2), UVM_HIGH)
            `uvm_info(get_type_name(),$sformatf("addition match"),UVM_NONE)
          end else begin
            // `uvm_info("", $sformatf("mon y_out : %0d  drv_data 1 : %0d drv_data 2 : %0d", seq_mon.y_out, seq_drv.data1, seq_drv.data2), UVM_NONE)
            `uvm_error(get_type_name(),$sformatf("addition not match"))
          end
        end else if (seq_mon.y_out == (seq_drv.data1 - seq_drv.data2)) begin
          // `uvm_info("", $sformatf("mon y_out : %0d  drv_data 1 : %0d drv_data 2 : %0d", seq_mon.y_out, seq_drv.data1, seq_drv.data2), UVM_NONE)
          `uvm_info(get_type_name(),$sformatf("subtraction match"),UVM_NONE)
          end else begin
            // `uvm_info("", $sformatf("mon y_out : %0d  drv_data 1 : %0d drv_data 2 : %0d", seq_mon.y_out, seq_drv.data1, seq_drv.data2), UVM_NONE)
            `uvm_error(get_type_name(),$sformatf("subtraction not match"))
          end
      end
    this.seq_count++;
    end
  endtask

  // function void write (usequence_item seq);
  //   `uvm_info(get_type_name(), "SCOREBOARD GOT THE SEQ FROM MONITOR", UVM_HIGH)
  //   seq.print();
  // endfunction


  function void write_mon (usequence_item seq);
    `uvm_info(get_type_name(), "SCOREBOARD GOT THE SEQ FROM MONITOR", UVM_HIGH)
    seq_mon_q.push_back(seq);
    this.seq_count_mon++;
    // seq.print();
    // -> monitor_trigger;
  endfunction

  function void write_drv (usequence_item seq);
    `uvm_info(get_type_name(), "SCOREBOARD GOT THE SEQ FROM DRIVER", UVM_HIGH)
    seq_drv_q.push_back(seq);
    this.seq_count_drv++;
    // seq.print();
    // -> driver_trigger;
  endfunction

   virtual function void report_phase(uvm_phase phase);
   super.report_phase(phase);
   `uvm_info(get_type_name(), $sformatf("TRANSACTIONS PROCESSED IN SCOREBOARD  :  %0d ", this.seq_count), UVM_NONE)
   `uvm_info(get_type_name(), $sformatf("TRANSACTIONS RECIEVED IN SCOREBOARD FROM DRIVER :  %0d ", this.seq_count_drv), UVM_NONE)
   `uvm_info(get_type_name(), $sformatf("TRANSACTIONS RECIEVED IN SCOREBOARD FROM MONITOR :  %0d ", this.seq_count_mon), UVM_NONE)
 endfunction : report_phase

endclass