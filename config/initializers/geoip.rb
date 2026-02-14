require Rails.root.join('lib/geoip_client')

GEOIP = GeoipClient.build(
  path: Rails.root.join('data', 'GeoLiteCity.dat'),
  logger: Rails.logger
)
