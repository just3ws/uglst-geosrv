require 'spec_helper'

describe 'geo root endpoint', type: :request do
  it 'returns success' do
    get '/'

    expect(response).to have_http_status(:ok)
  end

  it 'returns the geoip envelope' do
    get '/'

    payload = JSON.parse(response.body)
    expect(payload).to have_key('geoip')
  end
end
