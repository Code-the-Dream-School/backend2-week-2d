require 'rails_helper'
RSpec.describe "CustomersControllers", type: :request do
  describe "get customers_path" do
    it "renders the index view" do
      FactoryBot.create_list(:customer, 10)
      get customers_path
      expect(response).to render_template(:index)
    end
  end
  describe "get customer_path" do
    it "renders the :show template" do
      customer = FactoryBot.create(:customer)
      get customer_path(id: customer.id)
      expect(response).to render_template(:show)
    end
    it "redirects to the index path if the customer id is invalid" do
      get customer_path(id: 5000) #an ID that doesn't exist
      expect(response).to redirect_to customers_path
    end
  end
  describe "get new_customer_path" do
      it "renders the :new template" do 
        get new_customer_path
       expect(response).to render_template(:new)
      end
  end
  describe "get edit_customer_path" do
    it "renders the :edit template" do 
      customer = FactoryBot.create(:customer)
      get edit_customer_path(id: customer.id)
      expect(response).to render_template(:edit)
    end
  end
  describe "post customers_path with valid data" do
    it "saves a new entry and redirects to the show path for the entry" do
      customer_attributes = FactoryBot.attributes_for(:customer)
      expect { post customers_path, params: {customer: customer_attributes}
    }.to change(Customer, :count)
      expect(response).to redirect_to customer_path(id: Customer.last.id)
    end
  end
  describe "post customers_path with invalid data" do
    it "does not save a new entry or redirect" do
      customer_attributes = FactoryBot.attributes_for(:customer)
      customer_attributes.delete(:first_name)
      expect { post customers_path, params: {customer: customer_attributes}
    }.to_not change(Customer, :count)
      expect(response).to render_template(:new)
    end
  end
  describe "put customer_path with valid data" do
    it "updates an entry and redirects to the show path for the customer" do 
      customer = FactoryBot.create(:customer, first_name:"Shy") #instead of using the randomised name from FB, I set a first_name for testing purposes. 
      expect(customer.first_name).to eq("Shy") #first test the name to make sure I've set the name correctly
      put customer_path(customer.id), params: {customer: {first_name: "Sara"}} #update first_name
      customer.reload #grabs updated customer data from the database
      expect(customer.first_name).to eq("Sara") #test to make sure name has successfully updated
      expect(response).to redirect_to customer_path(id: customer.id)
      
    end
  end
  describe "put customer_path with invalid data" do
    it "does not update the customer record or redirect" do
      customer = FactoryBot.create(:customer, phone:"5555555555") #create customer and set phone number
      expect(customer.phone).to eq("5555555555") #test number 
      put customer_path(customer.id), params: {customer: {phone: "52555255"}} #update number invalid entry
      customer.reload #refresh data
      expect(customer.phone).not_to eq("52555255")
      expect(response).to render_template(:edit) #redirect to edit
    end
  end
  describe "delete a customer record" do
    it "deletes a customer record" do
      customer = FactoryBot.create(:customer)
      customer.destroy
      expect(get customer_path(id: 5000))

    end
  end
end