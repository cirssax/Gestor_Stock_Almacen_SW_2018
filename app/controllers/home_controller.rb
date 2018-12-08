class HomeController < ApplicationController
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :permitted_parameters, if: :devise_controller?
  def index

  end
end
