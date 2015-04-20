class Users::DashboardController < Users::BaseController

  # GET /dashboard
  def index
    @event = Event.last
    # @event = nil
  end

  private

  def set_navs
    set_nav("user/dashboard")
  end

end

