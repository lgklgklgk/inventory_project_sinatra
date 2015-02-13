

module ClassHelper

# Private: print_objects
#
# Takes an array of objects and determines which class they belong to.
#
# Parameters:
# array - Array: an array of objects.
public
  def print_objects(array)
    if array[0].class == Product
      print_products(array)
    elsif array[0].class == Category
      print_categories(array)
    else
      print_locations(array)
    end
  end
  
# Private print_products
#
# Prints out a formatted list of all of the Product objects.
#
# Parameters:
# array - Array: an array containing all of the Product objects.

  
  def print_products(array)
    puts "id".ljust(5)+"category".ljust(15)+"location"
    puts "-" * 80
    array.each do |object|
      category_name = WAREHOUSE.execute("SELECT name FROM categories WHERE id = #{object.category_id}")[0]["name"]
      location_name = WAREHOUSE.execute("SELECT name FROM locations WHERE id = #{object.location_id}")[0]["name"]
      puts object.id.to_s.ljust(5) + category_name.ljust(15) + location_name
    end
  end
  
# Private print_locations
#
# Prints out a formatted list of all of the Location objects.
#
# Parameters:
# array - Array: an array containing all of the Location objects.  
  
  def print_locations(array)
    puts "id".ljust(5)+"name".ljust(15)
    puts "-" * 80
    array.each do |object|
      puts object.id.to_s.ljust(5) + object.name.ljust(15) 
    end
  end
  
# Private print_categories
#
# Prints out a formatted list of all of the Category objects.
#
# Parameters:
# array - Array: an array containing all of the Category objects.  
  
  def print_categories(array)
    puts "id".ljust(5)+"name".ljust(15)+"cost".ljust(6)+"description"
    puts "-" * 80
    array.each do |object|
      puts object.id.to_s.ljust(5) + object.name.ljust(15) + object.cost.to_s.ljust(6) + object.description
    end
  end
end