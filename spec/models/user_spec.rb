require 'spec_helper'

describe User do
  describe ".find_or_create_from_ominiauth" do
    context "for an auth hash that does not have the provider and uid of an already existing user" do
      let(:nonexisting_user) {
        User.new(
          provider: "github",
          uid: "1",
          username: "jarlax1",
          email: "jarlax1@launchacademy.com",
          avatar_url: "https://avatars2.githubusercontent.com/u/174825?v=3&s=400"
        )
      }
      let!(:auth_hash) {
        mock_auth_for(nonexisting_user)
      }
      it "should create a new user and return the newly created user" do
        user = User.find_or_create_from_omniauth(auth_hash)
        expect(user.uid).to eq(nonexisting_user.uid)
        expect(user.provider).to eq(nonexisting_user.provider)
        expect(User.count).to eq(1)
      end
    end

    context "for an auth hash that has the provider and uid of an already existing user" do
      let(:existing_user) {
        User.create(
          provider: "github",
          uid: "1",
          username: "jarlax1",
          email: "jarlax1@launchacademy.com",
          avatar_url: "https://avatars2.githubusercontent.com/u/174825?v=3&s=400"
        )
      }
      let!(:auth_hash) {
        mock_auth_for(existing_user)
      }
      it "should return the existing user" do
        user = User.find_or_create_from_omniauth(auth_hash)
        expect(user).to eq(existing_user)
      end
    end
  end
end
