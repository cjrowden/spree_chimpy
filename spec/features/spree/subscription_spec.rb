require 'spec_helper'

feature 'Chimpy', :js do
  background do
    visit '/signup'
  end

  scenario 'guest subscription deface data-hook confirmation' do
    skip 'its not set by default'
    page.find('#footer-right')
  end

  scenario 'user subscription with opt_in' do
    subscribe!

    expect(current_path).to eq spree.root_path
    expect(page).to have_selector '.alert-notice', text: 'Welcome! You have signed up successfully.'
    expect(Spree::User.count).to be(1)
    expect(Spree::User.first.subscribed).to be_truthy
  end

  def subscribe!
    expect(page).to have_text 'Sign me up to the newsletter'

    fill_in 'Email', with: FFaker::Internet.email
    fill_in 'Password', with: 'secret123'
    fill_in 'Password Confirmation', with: 'secret123'

    check 'Sign me up to the newsletter'

    expect(page.has_checked_field?('spree_user_subscribed')).to be_truthy
    click_button 'Create'
  end
end
