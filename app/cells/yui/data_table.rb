class YUI::DataTable < YUI::Widget

  attr_accessor :columns

  attr_reader :start_index, :records_per_page, :sort_by, :sort_dir

  attr_accessor :total_records


  transition :from => :display, :to => :load  # browser event.
  transition :from => :load,    :to => :update #, :and => :back ### TODO: implement me.
  transition :from => :update,  :to => :load

  # State method called when DataTable is created. The block from #render_widget is yield (?)
  # here, so use #render_widget to define the columns.
  #
  # Example:
  #  render_widget('my_grid') do |w|
  #    w.add_column
  def display
    ### TODO: add configuration process here.
    @columns  = []
    @records_per_page = 10

    yield self if block_given?

    #nil
    render
  end

  def add_column(field) ### TODO: add explicit args label, sortable, ...!
    columns << {:key => field, :label => field, :sortable => true}
  end

  # State method called whenever the DataTable's DataSource needs to load
  # data via AJAX.
  def load
    ### TODO: validation, of course.

    @start_index      = param(:startIndex)
    @records_per_page = param(:results)
    @sort_by          = param(:sort)
    @sort_dir         = param(:dir)

    trigger :dataTableLoad
    ""
  end

  # Sends +table+ as new grid content to the connected DataTable control in the browser.
  # Data structure is an array of hashes, whereas each hash maps column names to cell values.
  #
  # Note that this method must be called during a <tt>:dataTableLoad</tt> event cycle, e.g. in
  # a #respond_to_event callback in a controller.
  #
  # Example for +table+:
  #  [{:name => "Nick Sutterer",  :country => "Germany"},
  #   {:name => "Mike Pence",     :country => "US and A"}]
  def grid=(table)
    @grid = table
    invoke! :update
  end

  # Returns the new grid page content as JSON.
  def update
    result_set = @grid

    {:ResultSet =>
      {
        #:totalResultsReturned => result_set.size,
        #:firstResultPosition  => 1,#start,
        #:sortedBy             => sort,
        #:dir              => dir,
        :Result               => result_set
      },
      "totalRecords"          => total_records,
    }.to_json
  end
end
