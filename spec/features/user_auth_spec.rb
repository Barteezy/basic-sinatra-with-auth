require 'spec_helper'

feature "User Authentication" do
  scenario "user can register, login, and logout" do
    visit "/"
    expect(page).to have_content "Register"

    click_on "Register"

    expect(page).to have_content "Sign Up"

    fill_in "Username", :with => "bob"
    fill_in "Password", :with => "bob"

    click_on "Sign Up"

    expect(page).to have_content "Thanks for registering"

    expect(page).to have_content "Sign In"

    fill_in "Username", :with => "bob"
    fill_in "Password", :with => "bob"

    click_on "Sign In"

    expect(page).to have_content "Welcome bob"

    click_on "Logout"

    expect(page).to have_content "You are now signed out"

  end
end