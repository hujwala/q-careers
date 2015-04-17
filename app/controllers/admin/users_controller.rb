module Admin
  class UsersController < Poodle::AdminController

    before_filter :require_q_careers_admin

    def refresh
      User.fetch_all_users(current_user.auth_token)
      render action: :index
    end

    def make_recruiter
      change_q_careers_role("recruiter")
    end

    def make_volunteer
      change_q_careers_role("volunteer")
    end

    def remove_recruiter
      change_q_careers_role("volunteer")
    end

    def remove_volunteer
      change_q_careers_role("employee")
    end

    def make_q_careers_admin
      change_q_careers_role("q_careers_admin")
    end

    def remove_q_careers_admin
      change_q_careers_role("employee")
    end

    private

    def get_collections
      # Fetching the users
      relation = User.where("")
      @filters = {}
      if params[:query]
        @query = params[:query].strip
        relation = relation.search(@query) if !@query.blank?
      end

      if params[:q_careers_role]
        @q_careers_role = params[:q_careers_role].strip
        relation = relation.q_careers_role(@q_careers_role) if !@q_careers_role.blank?
      end

      @per_page = params[:per_page] || "20"
      @users = relation.order("created_at desc").page(@current_page).per(@per_page)

      ## Initializing the @user object so that we can render the show partial
      @user = @users.first unless @user

      return true
    end

    def change_q_careers_role(new_role)
      @user = User.find(params[:id])
      @user.update_attribute(:q_careers_role, new_role)
      render_show
    end

  end
end
