module StoresHelper
  def store_info(s)
  	[s.address, s.phone, s.opening_hours].select { |x| x.present? }.join ", "
  end

  def url_to_store_location_on_gmap store
  	"https://maps.google.com/?hl=ru&q=loc:#{store.lat},#{store.lng}"
  end
end
