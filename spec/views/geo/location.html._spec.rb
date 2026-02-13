require 'spec_helper'

describe 'geo location lookup', type: :request do
  it 'uses the explicit ip param when provided' do
    get '/', params: { ip: '8.8.8.8' }

    payload = JSON.parse(response.body)
    expect(payload.fetch('geoip').fetch('ip')).to eq('8.8.8.8')
  end
end
