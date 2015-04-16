class Admin::WelcomeController < ApplicationController

  layout 'poodle/public'
  before_filter :redirect_to_appropriate_page_after_sign_in

  def home
  end

end
