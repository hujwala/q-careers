class Public::BaseController < ApplicationController

  layout 'public'
  before_filter :set_navs, :parse_pagination_params

  def stylesheet_filename
    @stylesheet_filename = "application"
  end

  def javascript_filename
    @javascript_filename = "application"
  end

end
