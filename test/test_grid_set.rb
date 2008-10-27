require 'test_helper'

class GridSetTest < ActiveSupport::TestCase
  
  def test_construction
    gc = GridSet.new
    
    assert_kind_of Array, gc
  end
  
  
  def test_adding_the_items
    gc = GridSet.new
    gc.concat [1,2,3,4]
    
    assert_equal 4, gc.size
  end
  
  def test_paging
    gc = GridSet.new
    gc.push(1,2,3,4)
    
    #assert_equal 4, gc.total
    
    items = gc.page_for(1, 2)
    assert_kind_of GridSet, items
    assert_equal 1, items.first
    assert_equal 2, items.last
    
    items = gc.page_for(2, 2)
    assert_kind_of GridSet, items
    assert_equal 3, items.first
    assert_equal 4, items.last
    
    #assert_equal 4, items.total
  end
  
  def test_slicing
    gc = GridSet.new
    gc.push(1,2,3,4)
    
    
    items = gc.slice(0, 2)
    assert_kind_of GridSet, items
    assert_equal 1, items.first
    assert_equal 2, items.last
    
    items = gc.page_for(2, 2)
    assert_kind_of GridSet, items
    assert_equal 3, items.first
    assert_equal 4, items.last
  end
  
  def test_sorting
    gc = GridSet.new
    gc.push({:id => 1}, {:id => 2}, {:id => 3}, {:id => 4})
    
    
    gc.order(:id)
    assert_equal({:id => 1}, gc.first)
    assert_equal({:id => 4}, gc.last)
    
    gc.order(:id, :desc)
    assert_equal({:id => 4}, gc.first)
    assert_equal({:id => 1}, gc.last)
  end
end
