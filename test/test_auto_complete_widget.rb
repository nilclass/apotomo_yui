require File.expand_path(File.dirname(__FILE__) + "/../../apotomo/test/test_helper")

class AutocompleteTest < ActionController::TestCase
  include Apotomo::UnitTestCase
  
  def test_widget_shortcut
    w = yui_autocomplete('my_autocomplete')
    assert_kind_of YUI::AutoComplete, w
    assert_equal 'my_autocomplete', w.name
  end
  
  def test_display
    w = yui_autocomplete('my_autocomplete')
    c = w.invoke
    assert_state w, :display
    assert c.size > 0
  end
  
end