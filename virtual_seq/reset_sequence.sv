class reset_sequence extends uvm_sequence #(reset_sequence_item);

    reset_sequence_item seq_item;

    `uvm_object_utils(reset_sequence)


  function new(string name = "reset_sequence");
    super.new(name);
    `uvm_info(get_type_name(), "SEQUENCE HAS BEEN CALLED", UVM_NONE)
  endfunction

    task body();
    `uvm_info(get_type_name(), " SEQUENCE BODY TASK ", UVM_NONE)
    repeat (3) begin
    seq_item = reset_sequence_item :: type_id::create("seq_item");
    start_item(seq_item);
    void'(seq_item.randomize());
    finish_item(seq_item);
    // get_response(seq_item);
    response_queue_depth = 1000;
    // seq_item.print();
    end
    endtask

endclass