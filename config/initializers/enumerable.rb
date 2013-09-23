module Enumerable
  # passes true as second param if element is last
  def each_with_is_last &block
    each_with_index do |el, ind|
      if ind == (self.length - 1)
        yield el, true
      else
        yield el, false
      end
    end
  end
end