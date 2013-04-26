class HomeController < ApplicationController
  def index

      if params[:application_numbers]
        applications = params[:application_numbers].split("\r\n").map{ |i| i.strip }
        @results = USCISStatus.check(applications)
      else
        @results = []
      end

  end
end
