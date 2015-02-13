require "pry"
require "sinatra"
require "sqlite3"

WAREHOUSE = SQLite3::Database.new('warehouse.db')
WAREHOUSE.results_as_hash = true
WAREHOUSE.execute("CREATE TABLE IF NOT EXISTS products
                 (id INTEGER PRIMARY KEY,
                  category_id INTEGER,
                  location_id INTEGER)")
WAREHOUSE.execute("CREATE TABLE IF NOT EXISTS categories
                 (id INTEGER PRIMARY KEY,
                  name TEXT,
                  description TEXT,
                  cost INTEGER)")
WAREHOUSE.execute("CREATE TABLE IF NOT EXISTS locations
                 (id INTEGER PRIMARY KEY,
                  name TEXT)")
                  
require_relative "models/modules.rb"
require_relative "models/class_modules.rb"
require_relative "models/location.rb"
require_relative "models/category.rb"
require_relative "models/product.rb" 
require_relative "models/helper.rb"

helpers ClassHelper
   

get "/error" do
  @products = Product.seek_all
  @categories = Category.seek_all
  @locations = Location.seek_all
  erb :error
end      

get "/" do
  @products = Product.seek_all
  @categories = Category.seek_all
  @locations = Location.seek_all
  erb :index
end 

get "/next" do
  @products = Product.seek_all
  @categories = Category.seek_all
  @locations = Location.seek_all
  case params["option"]
  when "add"
    redirect to("/add")
  when "edit"
    redirect to("/edit")
  when "delete"
    redirect to("/delete")
  end
end

get "/add" do
  @products = Product.seek_all
  @categories = Category.seek_all
  @locations = Location.seek_all
  erb :add
end

get "/edit" do
  @products = Product.seek_all
  @categories = Category.seek_all
  @locations = Location.seek_all
  erb :edit  
end

get "/delete" do
  @products = Product.seek_all
  @categories = Category.seek_all
  @locations = Location.seek_all
  erb :delete
end

get "/add_menu" do
  table = params["table"]
  it_works = Object.const_get(table)
  @products = Product.seek_all
  @categories = Category.seek_all
  @locations = Location.seek_all
  @vars = it_works.variables
  @table = params["table"]
  erb :add_menu
end

get "/edit_menu" do
  table = params["table"]
  it_works = Object.const_get(table)
  it_works.seek("id", params["id"])
  @products = Product.seek_all
  @categories = Category.seek_all
  @locations = Location.seek_all
  @id = params["id"]
  @var = it_works.variables
  @table = params["table"]
  erb :edit_menu
end

get "/delete_menu" do
  table = params["table"]
  it_works = Object.const_get(table)
  a = it_works.seek("id", params["id"])
  test_array =[]
  if it_works == Category || it_works == Location
    column_name = it_works.to_s.downcase + "_id"
    test_array = Product.seek(column_name, params["id"])
  end
  if test_array == []
    a[0].mark_x
    a[0].cram
  else redirect to("/error")
  end
  @products = Product.seek_all
  @categories = Category.seek_all
  @locations = Location.seek_all
  @id = params["id"]
  @var = it_works.variables
  @table = params["table"]
  erb :delete_menu
end


get "/cram" do
  @products = Product.seek_all
  @categories = Category.seek_all
  @locations = Location.seek_all
  table = params["table"]
  it_works = Object.const_get(table)
  params.delete("table")
  if params.has_key?("id")
    a = it_works.new(params)
    a.id= a.id.to_i
    a.cram
  else
    params["id"] = nil
    a = it_works.new(params)
    a.cram
  end
  erb :cram
end
