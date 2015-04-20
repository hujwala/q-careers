class Volunteer::EventsController < Poodle::AdminController

  before_filter :require_volunteer
  skip_before_filter :require_admin

  private

  def default_collection_name
    "events"
  end

  def default_item_name
    "event"
  end

  def default_class
    Event
  end

  def prepare_query
    @relation = Event.upcoming_events
    if params[:query]
      @query = params[:query].strip
      @relation = @relation.search(@query) if !@query.blank?
    end
  end

  def set_navs
    set_nav("volunteer/registrations")
    set_title("Registrations | Q-Careers")
  end

end
