require 'rails_helper'
RSpec.describe UserMailer, type: :mailer do
  before(:each) do
    @user = User.create(email: Faker::Internet.email, password: "password", password_confirmation: "password", confirmed_at: 7.days.ago)
  end
  include ActiveJob::TestHelper
  it 'sub_mail is sent' do
    expect {
      perform_enqueued_jobs do
        UserMailer.welcome_subs(@user.id).deliver
      end
    }.to change { ActionMailer::Base.deliveries.size }.by(1)
  end
  it 'image_mail is sent' do
    expect {
      perform_enqueued_jobs do
        UserMailer.welcome_images(@user.id).deliver
      end
    }.to change { ActionMailer::Base.deliveries.size }.by(1)
  end
  it 'sub_mail is sent to the right user' do
    perform_enqueued_jobs do
      UserMailer.welcome_subs(@user.id).deliver
    end

    mail = ActionMailer::Base.deliveries.last
    expect(mail.to[0]).to eq @user.email
  end
  it 'image_mail is sent to the right user' do
    perform_enqueued_jobs do
      UserMailer.welcome_images(@user.id).deliver
    end

    mail = ActionMailer::Base.deliveries.last
    expect(mail.to[0]).to eq @user.email
  end
end