require 'rails_helper'

RSpec.describe Public::WelcomeController, type: :controller do
	describe "GET index" do
		render_views
    it "should show welcome message" do
      get :home
      assert_response :success
      expect(response).to render_template("home")
      expect(response.code).to eq("200")
    end
  end
end