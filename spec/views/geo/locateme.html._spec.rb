require 'spec_helper'

describe 'geo locateme behavior', type: :request do
  it 'falls back to request ip when no ip param is provided' do
    get '/'

    payload = JSON.parse(response.body)
    expect(payload.fetch('geoip').fetch('ip')).to eq('127.0.0.1')
  end
end
