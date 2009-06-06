require File.expand_path(File.dirname(__FILE__) + "/../../apotomo/test/test_helper")

class DataTableTest < ActionController::TestCase
  include Apotomo::UnitTestCase
  
  def test_widget_shortcut
    w = yui_data_table('my_data_table')
    assert_kind_of YUI::DataTable, w
    assert_equal 'my_data_table', w.name
  end
  
  def test_display
    w = yui_data_table('my_data_table')
    c = w.invoke
    assert_state w, :display
    #assert c.size > 0
  end
  
  def test_load_api_without_data_provider
    controller.params = {
      :startIndex   => 0,
      :results      => 10,
      :sort         => :callname,
      :dir          => :asc}
      
    w = yui_data_table('my_data_table')
    w.invoke :display
    c = w.invoke :load
    
    assert_state w, :load
    assert_event :dataTableLoad, w.name
    
    assert_equal 0,         w.start_index
    assert_equal 10,        w.results_per_page
    assert_equal :callname, w.sort_by
    assert_equal :asc,      w.sort_dir
  end
end