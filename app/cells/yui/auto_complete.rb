class YUI::AutoComplete < YUI::Widget
  
  transition :from  => :display, :to => :load
  transition :in    => :load
  
  def query_string
    param(:query)
  end
  
  def matches=(items)
    @matches = items
    
    invoke!(:load)
  end
  
  def display
    ### TODO: add configuration process here.
  end
  
  def load
    @matches.collect{|k,v| "#{k}\t#{v}"}.join("\n")
  end
  
end
