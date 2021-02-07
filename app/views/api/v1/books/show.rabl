object @book
attributes :id, :title, :category_id, :price, :category
child(:author) { attributes :id, :first_name, :last_name }
child(:category) { attributes :id, :name }
