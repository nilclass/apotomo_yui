::Apotomo::WidgetShortcuts

module ::Apotomo::WidgetShortcuts
  
  ### FIXME: test me.
  def yui_autocomplete(id)
    YUI::AutoComplete.new(controller, id, :display)
  end
end