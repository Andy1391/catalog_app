object @order 
attributes :id, :name, :phone, :adress, :email, :total_price
  child :books, :object_root => false do
    attributes :id, :title, :author_id, :category_id, :price  
end
