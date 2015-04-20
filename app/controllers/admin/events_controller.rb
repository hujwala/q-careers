class Admin::EventsController < Poodle::AdminController

  before_filter :require_admin

  private

  def permitted_params
    params[:event].permit(:name, :slug, :date, :venue ,:description)
  end

  def set_navs
    set_nav("admin/events")
  end

end
