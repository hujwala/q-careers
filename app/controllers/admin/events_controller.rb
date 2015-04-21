class Admin::EventsController < Poodle::AdminController

  before_filter :require_admin

  private

  def get_collections
    relation = Event.where("")

    @filters = {}
    if params[:query]
      @query = params[:query].strip
      relation = relation.search(@query) if !@query.blank?
    end

    @per_page = params[:per_page] || "20"
    @events = relation.order("date desc").page(@current_page).per(@per_page)

    ## Initializing the @event object so that we can render the show partial
    @event = @events.first unless @event

    return true
  end

  def permitted_params
    params[:event].permit(:name, :slug, :date, :venue ,:description, :start_time, :end_time, :map_link, :contact_person, :contact_number)
  end

  def set_navs
    set_nav("admin/events")
  end

end
