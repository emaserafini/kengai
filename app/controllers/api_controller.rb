class APIController < ActionController::Base
  protect_from_forgery unless: -> { request.format.json? }

  rescue_from ActiveRecord::RecordNotFound, with: :render_no_record_found


  private

  def render_no_record_found
    render json: { errors: 'record not found' }, status: 404
  end

  def authenticate_token
    authenticate_with_http_token do |token, options|
      @thermostat.access_token == token
    end
  end

  def render_unauthorized
    headers['WWW-Authenticate'] = 'Token realm="Application"'
    render json: { errors: 'invalid token' }, status: :unauthorized
  end

  def authenticate
    authenticate_token || render_unauthorized
  end
end
