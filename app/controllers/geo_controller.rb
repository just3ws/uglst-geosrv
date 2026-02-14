class GeoController < ApplicationController
  def index; end

  def location
    @geo = lookup_by_ip(resolved_ip)

    render 'location', formats: 'json'
  end

  private

  def resolved_ip
    ip = params[:ip].to_s.strip
    ip = nil if ip.empty?
    ip || request.ip
  end

  def lookup_by_ip(ip)
    if ip
      begin
        GEOIP.city(ip) || { ip: ip }
      rescue StandardError => e
        logger.warn("geoip_lookup_error=#{e.class} ip=#{ip.inspect} message=#{e.message.inspect}")
        { ip: ip }
      end
    else
      { message: "You didn't supply an IP to geocode." }
    end.to_hash.symbolize_keys
  end
end
