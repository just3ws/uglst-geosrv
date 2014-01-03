require 'metrics_hash'

class ApplicationController < ActionController::Base
  protect_from_forgery

  after_filter :set_access_control_headers
  around_filter :log_metrics

  private

  def set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Request-Method'] = '*'
  end

  def log_metrics
    xff = request.headers['X-Forwarded-For'] || ''
    requestor_ip = xff.split(/, ?/)[0] || request.ip

    metrics = MetricsHash.new
    metrics['request_controller'] = request.params[:controller]
    metrics['request_action'] = request.params[:action]
    metrics['request_ip'] = request.ip
    metrics['request_xff'] = xff
    metrics['request_requestor_ip'] = requestor_ip
    metrics['request_url'] = request.url
    metrics['request_method'] = request.method.to_s

    yield
    # output metrics that were stored in logger.metrics[]
    logger.info { metrics.to_s }
  end
end
