require 'spec_helper'

feature "User signs in" do
  let(:user) do
    User.create(
      provider: "github",
      uid: "1",
      username: "jarlax1",
      email: "jarlax1@launchacademy.com",
      avatar_url: "https://avatars2.githubusercontent.com/u/174825?v=3&s=400"
    )
  end

  scenario "successful sign in" do
    visit '/'
    sign_in_as user

    expect(page).to have_content "You're now signed in as #{user.username}!"
  end

  scenario "successful sign out" do
    visit '/'
    sign_in_as user
    click_link "Sign Out"

    expect(page).to have_content "You have been signed out"
  end
end
