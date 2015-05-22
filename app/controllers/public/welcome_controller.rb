class Public::WelcomeController < Public::BaseController

  def home
    @event = QcareerConfiguration.homepage_event
    @event = Event.find_by_slug("qwinix-careers") unless @event
    @career_interest = CareerInterest.new
    @fresher = Fresher.new
	end

	private

  def set_navs
    set_nav("public/welcome")
  end

end
