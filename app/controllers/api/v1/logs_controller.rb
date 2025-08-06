class Api::V1::LogsController < ApplicationController
  LOG_KEYS = %w[level message timestamp source ray_id raw_log].freeze

  def create
    log_params_array = Array.wrap(log_params).map(&:to_h)

    if log_params_array.empty?
      return render json: { status: "error", message: "Log data is missing" }, status: :bad_request
    end

    log_attributes = log_params_array.map do |log_hash|
      LOG_KEYS.index_with { |key| log_hash[key] }
    end

    current_time = Time.current
    log_attributes.each do |attrs|
      attrs[:created_at] = current_time
      attrs[:updated_at] = current_time
    end


    result = Log.insert_all(log_attributes)
    render json: { status: "success", created_logs: result.count }, status: :created

  rescue ActionController::ParameterMissing => e
    render json: { status: "error", message: e.message }, status: :bad_request
  rescue => e
    render json: { status: "error", message: e.message }, status: :internal_server_error
  end

  private

  def log_params
    params.permit(_json: [ :level, :message, :timestamp, :source, :ray_id, raw_log: {} ])
          .fetch(:_json, [])
  end
end
