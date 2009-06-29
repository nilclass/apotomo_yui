require File.expand_path(File.dirname(__FILE__) + "/../../apotomo/test/test_helper")

class TreeViewTest < ActionController::TestCase
  include Apotomo::UnitTestCase
  
  def test_widget_shortcut
    w = yui_tree_view('my_tree_view')
    assert_kind_of YUI::TreeView, w
    assert_equal 'my_tree_view', w.name
  end
  
  def test_api
    w = yui_tree_view('my_tree_view')
    
    w.root_items = [1,2,3]
    assert_equal [1,2,3], w.root_items
  end
  
  def test_current_label
    w = yui_tree_view('my_tree_view')
    @controller.params = {:query => "my_label"}
    assert_equal "my_label", w.current_label
  end
  
end