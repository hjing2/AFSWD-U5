# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require "csv"
require 'faker'

# clear existing data
Product.destroy_all
Category.destroy_all

# read the csv file
csv_file = Rails.root.join('db/products.csv')
csv_data = File.read(csv_file)

# If CSV was created by Excel in Windows you may also need to set an encoding type:
# products = CSV.parse(csv_data, headers: true, encoding: 'iso-8859-1')

# parse the csv data
products = CSV.parse(csv_data, headers: true)

# handle the csv data
products.each do |product|
    # get the category name
    category_name = product['category_name']
    category = Category.find_or_create_by(name: category_name)

products.each do |product|

    # Create categories and products here.
    Product.create(
        title: product['title'],
        description: product['description'],
        price: product['price'],
        stock_quantity: product['stock_quantity'],
        category: category
    )

end

category = Category.find_or_create_by(name: category_name)

# Where "category_name" is the category name as a string. You will need to get this from the data returned from the csv library.