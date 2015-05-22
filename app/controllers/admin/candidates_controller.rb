class Admin::CandidatesController < Poodle::AdminController

  before_filter :require_admin

  private

  def get_collections
    relation = Candidate.where("")

    @filters = {}
    if params[:query]
      @query = params[:query].strip
      relation = relation.search(@query) if !@query.blank?
    end

    @per_page = params[:per_page] || "20"
    @candidates = relation.order("name asc").page(@current_page).per(@per_page)

    return true
  end

  def permitted_params
    params[:candidate].permit(:name, :slug, :date, :venue ,:description, :start_time, :end_time, :map_link, :contact_person, :contact_number)
  end

  def set_navs
    set_nav("admin/candidates")
  end

end
