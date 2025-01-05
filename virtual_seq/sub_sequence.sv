class sub_usequence extends usequence ;

    usequence_item seq_item;

    `uvm_object_utils(sub_usequence)


  function new(string name = "sub_usequence");
    super.new(name);
    `uvm_info(get_type_name(), "SEQUENCE HAS BEEN CALLED", UVM_HIGH)
  endfunction

    task body();
    `uvm_info(get_type_name(), " SEQUENCE BODY TASK ", UVM_HIGH)
    repeat (499) begin
    seq_item = usequence_item :: type_id::create("seq_item");
    start_item(seq_item);
    void'(seq_item.randomize() with {seq_item.control_in == 1'b0;});
    finish_item(seq_item);
    get_response(seq_item);
    response_queue_depth = 500;
    // seq_item.print();
    end
    endtask

endclass