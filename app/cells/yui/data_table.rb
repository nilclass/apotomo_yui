class YUI::DataTable < YUI::Widget
  
  attr_accessor :columns
  attr_accessor :set
  
  def transition_map
    { :data_table => [:load],
      :load => [:load],
    }
  end
  
  # State method called when DataTable is created.
  def data_table
    ### TODO: add configuration process here.
    @columns  = []
    @set      = []
    @items_per_page = 2
    
    nil
  end
  
  # Define columns in block.
  def define(&block)
    yield block self
  end
  
  def add_column(field) ### TODO: add explicit args label, sortable, ...!
    columns << {:key => field, :label => field, :sortable => true}
  end
  
  # State method called whenever the DataTable's DataSource needs to load 
  # data via AJAX.
  def load
    ### TODO: validation, of course.
    start   = param(:startIndex).to_i
    puts "start: #{start.inspect}"
    results = param(:results).to_i
    puts "amount: #{results.inspect}"
    sort    = param(:sort).to_sym ### TODO: what if keys are not syms?
    dir     = param(:dir).to_sym
    
    result_set = query_for(start, results, sort, dir)
    { :recordsReturned  => results,
      :totalRecords     => total_records,
      :startIndex       => start,
      :sort             => sort,
      :dir              => dir,
    #"pageSize":10,
      :records          => result_set
    }.to_json
  end
  
  # Override for retrieving match data.
  def query_for(start, amount, order, dir)
    set.slice(start, amount).order(order, dir)
  end
  
  # Calculate total amount of records.
  def total_records
    set.size
  end
end
