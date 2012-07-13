# encoding: utf-8

class GeoController < ApplicationController
  def index
  end

  def location

    @geo = lookup_by_ip(params[:ip] || request.ip)

    render 'location', formats: 'json'
  end

  private

  def lookup_by_ip(ip)
    if ip
      GEOIP.city(ip) || {ip: ip}
    else
      {message: "You didn't supply an IP to geocode."}
    end.to_hash.symbolize_keys
  end
end
