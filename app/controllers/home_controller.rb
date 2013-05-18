class HomeController < ApplicationController
  before_filter :redirect_authenticated_user

  def index
    @results = []

    if params[:application_numbers]
      applications = params[:application_numbers].split("\r\n").map{ |i| i.strip }
      @results = USCISStatus.check(applications)
    end

    respond_to do |format|
      format.html
      format.json { render json: @results}
    end
  end

  private

    def redirect_authenticated_user
      redirect_to dashboard_path if signed_in?
    end
end
