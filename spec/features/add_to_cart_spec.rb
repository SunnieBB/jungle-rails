require 'rails_helper'

RSpec.feature "User is able to add a product to cart from the homepage", type: :feature, js: true do
  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "They add product and update cart from 0 - 1" do
    # ACT
    visit root_path
    # puts page.html
    click_button 'Add', match: :first
    sleep 5
    # DEBUG
    save_screenshot
  
      # VERIFY
  expect(page).to have_content 'My Cart (1)'
  end
end
