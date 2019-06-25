# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you want to use :null_session instead.
  protect_from_forgery with: :null_session

  before_action :handle_html_requests

  # Avoid having an empty view file.
  def index
    render inline: ""
  end

  private

  # Required for initial page load so that the entire app isn't served as json
  def handle_html_requests
    render "layouts/application" if request.format.symbol == :html
  end
end
