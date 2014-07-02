require 'spec_helper'

feature 'User Auth' do
  scenario 'User can go to the registration pages from the homepage' do
    visit '/'
    click_on "Register"
    expect(page).to have_content('Username')
  end
  scenario 'User can register' do
    visit '/register'
    fill_in 'username', :with => 'luke'
    fill_in 'password', :with => 'password'
    click_on 'Submit'
    visit '/'
    expect(page).to_not have_content('Thank you for registering')

  end

end