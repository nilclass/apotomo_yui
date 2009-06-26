::Apotomo::WidgetShortcuts

module ::Apotomo::WidgetShortcuts
  protected
  
  def yui_autocomplete(id)
    YUI::AutoComplete.new(controller, id, :display)
  end
  
  def yui_data_table(id)
    YUI::DataTable.new(controller, id, :display)
  end
  
  def yui_tree_view(id)
    YUI::TreeView.new(controller, id, :display)
  end
  
end