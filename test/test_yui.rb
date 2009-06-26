require File.expand_path(File.dirname(__FILE__) + "/../../apotomo/test/test_helper")

YUI::Configuration.build_url= "yui.yahooapis.com/2.7.0/build/"

class AutocompleteTest < ActionController::TestCase
  include Apotomo::UnitTestCase
  
  def test_build_url
    assert_equal "yui.yahooapis.com/2.7.0/build/", YUI::Configuration.build_url
    
    YUI::Configuration.build_url = "/build/"
    assert_equal "/build/", YUI::Configuration.build_url
  end
  
end