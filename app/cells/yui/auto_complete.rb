class YUI::AutoComplete < YUI::Widget
  def transition_map
    { :auto_complete => [:load],
      :load => [:load],
    }
  end
  
  def auto_complete
    ### TODO: add configuration process here.
  end
  
  def load
    query_for(param(:query)).collect{|k,v| "#{k}\t#{v}"}.join("\n")
  end
  
  def query_for(query)
    # override for retrieving match data.
    {}
  end
end
