# frozen_string_literal: true

require 'json'

class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :resource_not_found

  def resource_not_found
    render status: 404
  end
end
