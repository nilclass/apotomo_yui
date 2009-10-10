::Apotomo::WidgetShortcuts

module ::Apotomo::WidgetShortcuts
  protected
  
  def yui_autocomplete(id)
    YUI::AutoComplete.new(id, :display)
  end
  
  def yui_data_table(id)
    YUI::DataTable.new(id, :display)
  end
  
  def yui_tree_view(id)
    YUI::TreeView.new(id, :display)
  end
  
end