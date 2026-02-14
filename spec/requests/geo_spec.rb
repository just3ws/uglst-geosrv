require 'spec_helper'

REQUIRED_GEO_KEYS = %w[
  area_code
  city_name
  continent_code
  country_code2
  country_code3
  country_name
  dma_code
  ip
  latitude
  longitude
  postal_code
  region_name
  request
  timezone
].freeze

describe 'Geo endpoint', type: :request do
  it 'returns success and JSON content type for the root endpoint' do
    get '/'

    expect(response).to have_http_status(:ok)
    expect(response.content_type).to eq('application/json')
  end

  it 'returns CORS headers' do
    get '/'

    expect(response.headers['Access-Control-Allow-Origin']).to eq('*')
    expect(response.headers['Access-Control-Request-Method']).to eq('*')
  end

  it 'returns the required geoip contract keys' do
    get '/'

    payload = json_body
    expect(payload).to include('geoip')
    expect(payload.fetch('geoip').keys.sort).to eq(REQUIRED_GEO_KEYS.sort)
  end

  it 'uses query ip in preference to request.ip' do
    get '/', params: { ip: '8.8.8.8' }

    expect(json_body.fetch('geoip').fetch('ip')).to eq('8.8.8.8')
  end

  it 'treats blank ip param as missing and falls back to request ip' do
    get '/', params: { ip: '' }

    expect(json_body.fetch('geoip').fetch('ip')).to eq('127.0.0.1')
  end

  it 'handles invalid ip format gracefully with fallback response' do
    allow(GEOIP).to receive(:city).with('abc').and_raise(ArgumentError, 'invalid')

    get '/', params: { ip: 'abc' }

    expect(response).to have_http_status(:ok)
    expect(json_body.fetch('geoip').fetch('ip')).to eq('abc')
  end

  it 'handles malformed ipv6 input gracefully with fallback response' do
    allow(GEOIP).to receive(:city).with('2001:::1').and_raise(ArgumentError, 'invalid')

    get '/', params: { ip: '2001:::1' }

    expect(response).to have_http_status(:ok)
    expect(json_body.fetch('geoip').fetch('ip')).to eq('2001:::1')
  end

  it 'returns known geodata fields when lookup succeeds' do
    fake_city = {
      area_code: 0,
      city_name: 'Mountain View',
      continent_code: 'NA',
      country_code2: 'US',
      country_code3: 'USA',
      country_name: 'United States',
      dma_code: 807,
      ip: '8.8.8.8',
      latitude: 37.4056,
      longitude: -122.0775,
      postal_code: '94043',
      region_name: 'CA',
      request: nil,
      timezone: 'America/Los_Angeles'
    }
    allow(GEOIP).to receive(:city).with('8.8.8.8').and_return(double(to_hash: fake_city))

    get '/', params: { ip: '8.8.8.8' }

    geoip = json_body.fetch('geoip')
    expect(geoip.fetch('country_code2')).to eq('US')
    expect(geoip.fetch('country_name')).to eq('United States')
    expect(geoip.fetch('city_name')).to eq('Mountain View')
  end

  it 'continues response flow while emitting metrics log output' do
    logged = []
    allow(Rails.logger).to receive(:info) do |*_, &blk|
      logged << blk.call if blk
    end

    get '/'

    expect(response).to have_http_status(:ok)
    metrics_line = logged.find { |line| line.include?('request_controller=geo') }
    expect(metrics_line).to include('request_action=location')
    expect(metrics_line).to include('request_method=GET')
  end
end
