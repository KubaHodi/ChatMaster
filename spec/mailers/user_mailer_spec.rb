require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  let(:user) { FactoryBot.create(:user) }
  let(:email) { UserMailer.reset_password.deliver_now}
  describe "password/reset" do
    it "sends email with link to the user in order to resate password" do
      expect {
        post :create
      }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end
  end
end
