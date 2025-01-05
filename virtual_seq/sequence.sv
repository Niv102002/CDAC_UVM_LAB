class usequence extends uvm_sequence #(usequence_item);

    usequence_item seq_item_addr;
    int count_tx=0;

    `uvm_object_utils(usequence)


  function new(string name = "usequence");
    super.new(name);
    `uvm_info(get_type_name(), "SEQUENCE HAS BEEN CALLED", UVM_HIGH)
  endfunction

    task body();
    `uvm_info(get_type_name(), " SEQUENCE BODY TASK ", UVM_NONE)

    // repeat (2282) begin    //for 100 percent code coverage

    repeat (2) begin

    `ifdef NO_SEQ_MACRO

    seq_item_addr = usequence_item :: type_id::create("seq_item_addr");  //replaced with `uvm_do
    start_item(seq_item_addr);
    void'(seq_item_addr.randomize());
    finish_item(seq_item_addr);

    `elsif UVM_DO
    `uvm_do(seq_item_addr)

    `else
    `uvm_do_with(seq_item_addr, {data1==5;})

    `endif

    // `uvm_do_pri(seq_item_addr,0)   //priority

    // `uvm_do_pri_with (seq_item_addr, 1 , {data1==5;}) //priority with constarint


    // // //use below two together
    // `uvm_create(seq_item_addr) //equivalent to line :- seq_item_addr = usequence_item :: type_id::create("seq_item_addr");
    // `uvm_send(seq_item_addr)   // equivalent to start_item() and finish item()

    get_response(seq_item_addr);
    response_queue_depth = 2300;

    // `uvm_info(get_type_name(), "GET AND FINISH DONE SEQUENCE BODY TASK IN", UVM_NONE)
    // seq_item.print();
    
    end
    endtask

endclass

    // count_tx++;

    // if(this.count_tx == 100) begin
    //   // this.rst_th = 0;
    //   `uvm_info(get_type_name(), $sformatf("TRANSACTIONS REACHED 100 AT %0t", $time), UVM_NONE)
    //    // uvm_config_db#(int)::set(null, "*", "RESET_TH_KEY", this.rst_th);
    // end