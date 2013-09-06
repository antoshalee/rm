module CatalogItemsHelper
  def current_catalog_path_except key
    catalog_path(request.query_parameters.except(key))
  end

  def current_catalog_path_with param
    catalog_path(request.query_parameters.merge(param))
  end
end
