class Public::WelcomeController < Public::BaseController

  def home
    @event = Event.last
    @career_interest = CareerInterest.new
    @fresher = Fresher.new
	end

	private

  def set_navs
    set_nav("public/welcome")
  end

end
