require 'spec_helper'
require 'geoip_client'

describe GeoipClient do
  describe '.build' do
    let(:logger) { instance_double(Logger, warn: nil) }

    it 'returns GeoIP client when initialization succeeds' do
      client = instance_double(GeoIP)
      allow(GeoIP).to receive(:new).and_return(client)

      built = described_class.build(path: '/tmp/GeoLiteCity.dat', logger: logger)

      expect(built).to eq(client)
    end

    it 'falls back to a null client when GeoIP init fails' do
      allow(GeoIP).to receive(:new).and_raise(StandardError, 'corrupt db')

      built = described_class.build(path: '/tmp/missing.dat', logger: logger)

      expect(built).to be_a(GeoipClient::NullClient)
      expect(built.city('8.8.8.8')).to be_nil
      expect(logger).to have_received(:warn).with(include('geoip_init_error=StandardError'))
    end
  end
end
