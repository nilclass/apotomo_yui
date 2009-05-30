::Apotomo::WidgetShortcuts

module ::Apotomo::WidgetShortcuts
  protected
  
  ### FIXME: test me.
  def yui_autocomplete(id)
    YUI::AutoComplete.new(controller, id, :display)
  end
  
  ### FIXME: test me.
  def yui_data_table(id)
    YUI::DataTable.new(controller, id, :display)
  end
  
end