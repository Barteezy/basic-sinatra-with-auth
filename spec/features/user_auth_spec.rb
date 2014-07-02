require 'spec_helper'

feature 'User Auth' do
  scenario 'User can go to the registration pages from the homepage' do
    visit '/'
    click_on "Register"

    expect(page).to have_content('Username')
  end
end