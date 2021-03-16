collection @books
attributes :id, :title, :price, :category_id
child(:author) { attributes :id, :first_name, :last_name }
