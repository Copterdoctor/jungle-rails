require 'rails_helper'

RSpec.feature "AddToCarts", type: :feature, js: true do
  # SETUP
  before :each do
    @user = User.create(
      first_name: "Admin",
      last_name: "Admin",
      email: "test@test.com",
      password: "password",
      )

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

  scenario "They can add product to cart" do
    # ACT
    visit root_path
    click_on 'Login'

    expect(page).to have_css '#email'
    
    fill_in "email",	with: "test@test.com"
    fill_in "password",	with: "password"
    click_on 'Submit'
    
    expect(page).to have_css 'article.product', count: 10

    first('article.product').click_on 'Add'
    expect(page).to have_text' My Cart (1)', count: 1
    # DEBUG / VERIFY
    save_screenshot
  end
end
