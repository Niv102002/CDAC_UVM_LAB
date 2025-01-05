class driver extends uvm_driver #(usequence_item);
 
	parameter DATA_WIDTH = 4;  

	usequence_item seq;
  static int count_seq;
  static int rst_th;


	virtual intf #(.DATA_WIDTH(DATA_WIDTH)) vif;

  `uvm_component_utils(driver)

  function new(string name = "driver", uvm_component parent=null);
    super.new(name, parent);
    this.count_seq = 0;
    // seq = usequence_item :: type_id :: create("seq");
  endfunction


  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info(get_type_name(), " BUILD PHASE OF DRIVER ", UVM_HIGH)

    //  uvm_config_db#(virtual intf#(.DATA_WIDTH(DATA_WIDTH)))::get(this, "", "INTF_KEY", vif);
  
    if (uvm_config_db#(virtual intf#(.DATA_WIDTH(DATA_WIDTH)))::get(this, "", "INTF_KEY", vif)) begin
    `uvm_info(get_type_name(), "RECIEVED VIF", UVM_HIGH)
    end else begin
    `uvm_info(get_type_name(), " NOT RECIEVED VIF", UVM_HIGH)
      
    end

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
      if (vif.rst) begin
      seq_item_port.get_next_item (seq);
      `uvm_info(get_type_name(), "DRIVER GOT DATA FROM SEQUNCER ", UVM_HIGH)
      // seq.print();
      @(posedge vif.clk);
      vif.data1 <= seq.data1;
      vif.data2 <= seq.data2;
      vif.control_in <= seq.control_in;
      vif.en_in <= 1'b1;
      @(posedge vif.clk);
      vif.en_in <= 1'b0;
      @(posedge vif.clk);
      seq.y_out = vif.y_out;
      seq_item_port.put_response(seq);
      rsp_port.write(seq);

      this.count_seq++;
      // if(this.count_seq == 100) begin
      //   this.rst_th = 0;
      //   `uvm_info(get_type_name(), $sformatf("TRANSACTIONS REACHED 100 AT %0t", $time), UVM_NONE)
      //    uvm_config_db#(int)::set(null, "*", "RESET_TH_KEY", this.rst_th);
      // end

      seq_item_port.item_done(seq);

      end else begin
      `uvm_info(get_type_name(), "RESET IS HIGH ", UVM_HIGH)
        @(posedge vif.clk);
      end
    end

  endtask

   virtual function void report_phase(uvm_phase phase);
   super.report_phase(phase);
   `uvm_info(get_type_name(), $sformatf("TRANSACTIONS SENT FROM DRIVER  :  %0d ", this.count_seq), UVM_NONE)
   endfunction : report_phase


endclass
