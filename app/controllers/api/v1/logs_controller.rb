class Api::V1::LogsController < ApplicationController
  def create
    log_params_array = Array.wrap(log_params)

    current_time = Time.current
    log_attributes = log_params_array.map do |p|
      p.merge(created_at: current_time, updated_at: current_time)
    end

    if log_attributes.present?
      result = Log.insert_all(log_attributes)
      render json: { status: "success", created_logs: result.count }, status: :created
    else
      render json: { status: "error", message: "Log data is missing" }, status: :bad_request
    end
  rescue ActionController::ParameterMissing => e
    render json: { status: "error", message: e.message }, status: :bad_request
  rescue => e
    render json: { status: "error", message: e.message }, status: :internal_server_error
  end

  private

  def log_params
    params.permit(_json: [ :level, :message, :timestamp, :source, raw_log: {} ])
          .fetch(:_json, [])
  end
end
