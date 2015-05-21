class Admin::QcareerConfigurationsController < Poodle::AdminController

  before_filter :require_admin

  private

  def get_collections
    relation = QcareerConfiguration.where("")

    @filters = {}
    if params[:query]
      @query = params[:query].strip
      relation = relation.search(@query) if !@query.blank?
    end

    @per_page = params[:per_page] || "20"
    @qcareer_configurations = relation.order("created_at desc").page(@current_page).per(@per_page)

    ## Initializing the @event object so that we can render the show partial
    @qcareer_configuration = @qcareer_configurations.first unless @qcareer_configuration

    return true
  end

  def default_item_name
    "qcareer_configuration"
  end

  def permitted_params
    params[:configuration].permit(:name, :value)
  end

  def set_navs
    set_nav("admin/configurations")
  end

end
