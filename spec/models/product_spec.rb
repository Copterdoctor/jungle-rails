require 'rails_helper'

RSpec.describe Product, type: :model do
  describe "Validations" do
    category = Category.find_or_create_by! name: 'TestCategory'
    
    it "Creates a new product with valid info" do
      product = category.products.create( :name => "TestName", :price => 1, :quantity => 1,)
      expect(product).to be_valid
      expect(product.errors.full_messages).to eq([])
    end

    it "Requires a name" do
      product = category.products.create( :name => "", :price => 1, :quantity => 1,)
      expect(product).to_not be_valid
      expect(product.errors[:name]).to eq(["can't be blank"])
    end

    it "requires a price" do
      product = category.products.create( :name => "TestName", :price => "", :quantity => 1,)
      expect(product).to_not be_valid  
      expect(product.errors[:price]).to eq(["is not a number"])
    end

    it "Requires a quanity" do
      product = category.products.create( :name => "TestName", :price => 1, :quantity => nil,)
      expect(product).to_not be_valid
      expect(product.errors[:quantity]).to eq(["can't be blank"])
    end
    
    it "Requires a category" do
      product = Product.create( :name => "TestName", :price => 1, :quantity => 1,)
      expect(product).to_not be_valid
      expect(product.errors[:category]).to eq(["can't be blank"])
    end
    
    
  end
  
end
