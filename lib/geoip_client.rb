class GeoipClient
  class NullClient
    def city(_ip)
      nil
    end
  end

  def self.build(path:, logger:)
    GeoIP.new(path.to_s)
  rescue StandardError => e
    logger.warn("geoip_init_error=#{e.class} message=#{e.message.inspect}")
    NullClient.new
  end
end
