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

ActionController::Dispatcher.to_prepare do
  ActionView::Base.send(:include, YUI::Helper)
  Cell::View.send(:include, YUI::Helper)
end
