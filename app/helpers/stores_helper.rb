module StoresHelper
  def store_info(s)
  	[s.address, s.phone, s.opening_hours].select { |x| x.present? }.join ", "
  end
end
