# An intermediate data-store for Grids.
# Totally independent from YUI/ExtJS/Rails.

class GridSet < Array
  attr_accessor :total
  def initialize(*args)
    super(*args)
    
    @total = 0
  end
  
  def page_for(page, items_per_page)
    @total = size
    slice((page-1)*items_per_page, items_per_page)
  end
  
  ### TODO: validate args. provide more generic sorting.
  def order(by, dir=:asc)
    sort { |a,b| a[by] <=> b[by] }
    reverse! if dir == :desc
    self
  end
end
