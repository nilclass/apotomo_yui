class YUI::TreeView < YUI::Widget
  
  transition :from => :display, :to => :load  # browser event.
  transition :from => :load,    :to => :update #, :and => :back ### TODO: implement me.
  transition :from => :update,  :to => :load
  
  attr_accessor :root_items
  
  def current_label
    ### FIXME: encode in event:
    param(:query)
  end
    
  #
  # Usually called in an event responder.
  def current_items=(items)
    @current_items = items
    invoke! :update
  end
  
  # Returns the queried node's children as JSON.
  def update
    result_set = @current_items
        
    {:ResultSet =>
      { 
        :Result               => result_set
      },
    }.to_json
  end
  
  def display
    ### TODO: add configuration process here.
    
    yield self if block_given?
    
    nil
  end
  
  def load
    # place to prepare instance variables for the controller event responder, e.g.
    # @current_node = ...
    trigger :treeViewLoad
    ""
  end
  
end
