ProductsController.class_eval do
  
  Taxonomy.all.each do |t|
    has_scope t.filter_name
  end
  
  # TODO : directly customize searcher
  before_filter :get_filtered_products, :only => :index

  def get_filtered_products
    @filtered_products = apply_scopes(Product).all
  end
  
  
end