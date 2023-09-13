require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    it 'saves successfully with all fields set' do
      @category = Category.create(name: 'Example Category') # create a new category
      @product = Product.new(
        name: 'Example Product',
        price: 10.99,
        quantity: 5,
        category: @category
      )
      expect(@product.save).to be(true)
    end

    it 'validates presence of name' do
    # validates :name, presence: true
      @product = Product.new(
        name: nil,
        price: 10.99,
        quantity: 5,
        category: @category
        )

        @product.valid?
        # expect (@product.errors.full_messages).to be()
        # puts @product.errors.full_messages.to_sentence
        expect(@product.errors.full_messages.to_sentence).to eq("Category must exist, Name can't be blank, and Category can't be blank")
    end

    it 'validates presence of price' do
      # validates :price, presence: true
      @product = Product.new(
        name: 'Product',
        price: nil,
        quantity: 5,
        category: @category
        )

        @product.valid?
        expect(@product.errors.full_messages.to_sentence).to eq("Category must exist and Category can't be blank")
    end

    it 'validates presence of quantity' do
      # validates :quantity, presence: true
      @product = Product.new(
        name: 'Product',
        price: 10.99,
        quantity: nil,
        category: @category
      )
      @product.valid?
      expect(@product.errors.full_messages.to_sentence).to eq("Category must exist, Quantity can't be blank, and Category can't be blank")
    end

    it 'validates presence of category' do
      # validates :category, presence: true
      @product = Product.new(
        name: 'Product',
        price: 10.99,
        quantity: 5,
        category: nil
      )
      @product.valid?
      expect(@product.errors.full_messages.to_sentence).to eq("Category must exist and Category can't be blank")
    end
  end
end
