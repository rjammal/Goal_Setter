require 'spec_helper'

feature "the signup process" do 
  
  before(:each) do
    visit new_user_url
  end
  
  it "has a new user page" do
    expect(page).to have_content "Sign Up"
  end

  feature "signing up a user" do

    it "shows username on the homepage after signup" do
      fill_in "username", with: "GenericUser"
      fill_in "password", with: "password"
      click_button "Sign Up"
      
      expect(page).to have_content "GenericUser"
    end

  end

end

feature "logging in" do 

  it "shows username on the homepage after login" do
    u = User.create!(username: "GenericUser", password: "password")
    visit new_session_url
    fill_in "username", with: u.username
    fill_in "password", with: u.password
    click_button "Sign In"
    
    expect(page).to have_content u.username
  end

end

feature "logging out" do 

  it "begins with logged out state" do 
    visit new_session_url
    expect(page).to_not have_button("Sign Out")
  end

  it "doesn't show username on the homepage after logout" do
    visit new_session_url
    u = User.create!(username: "GenericUser", password: "password")
    visit new_session_url
    fill_in "username", with: u.username
    fill_in "password", with: u.password
    click_button "Sign In"
    click_button "Sign Out"
    
    expect(page).to_not have_content(u.username)
  end

end