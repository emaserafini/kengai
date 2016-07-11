class APIController < ActionController::Base
  protect_from_forgery unless: -> { request.format.json? }

  rescue_from ActiveRecord::RecordNotFound, with: :render_no_record_found


  private

  def render_no_record_found
    render json: { errors: 'record not found' }, status: 404
  end
end
