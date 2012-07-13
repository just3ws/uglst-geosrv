# encoding: utf-8

class GeoController < ApplicationController
  def index
  end

  def location
    @geo = lookup((params['ip'] || params[:ip]) || request.ip)

    render 'location', formats: 'json'
  end

  private

  def lookup(ip)
    if ip
      GEOIP.city(ip) || {}
    else
      {message: "You didn't supply an IP to geocode."}
    end.to_hash.symbolize_keys
  end
end
