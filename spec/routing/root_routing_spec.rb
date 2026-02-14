require 'spec_helper'

describe 'Root routing', type: :routing do
  it 'routes GET / to geo#location' do
    expect(get: '/').to route_to('geo#location')
  end
end
