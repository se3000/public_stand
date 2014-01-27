require 'spec_helper'

def log_in_as(auth)
  auth = auth.authentication if auth.is_a? User
  visit login_path

  unless auth.password.present?
    auth.update_attributes(password: 'password', password_confirmation: 'password')
  end

  fill_in 'Email', with: auth.email
  fill_in 'Password', with: auth.password
  click_button 'Log In'
end

def log_out
  visit log_out_path
end
