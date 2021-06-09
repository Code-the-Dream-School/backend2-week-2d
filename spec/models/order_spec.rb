require 'rails_helper'

RSpec.describe Order, type: :model do subject { Order.create(product_name: "Kakashist", product_count: 888, customer_id: 2)}
  # it "is valid with valid attributes" do
  #   expect(subject).to be_valid
  # end
  it "is not valid without a product_name" do
    subject.product_name=nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a product count" do 
    subject.product_count=nil
    expect(subject).to_not be_valid
  end
  it "is not valid if the product count is not all digits" do 
    subject.product_count = 'A12B456789'
    expect(subject).to_not be_valid
  end
  it "returns the correct product_name" do
    expect(subject.product_name).to eq("Kakashist")
  end
  
end
