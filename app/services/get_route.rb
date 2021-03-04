class GetRoute
  def initialize(stops_array)
    # @start_lat= attr[:start_lat]
    # @stop_lat = attr[:stop_lat]
    # @start_long= attr[:start_long]
    # @stop_long = attr[:stop_long]
    @stops = stops_array
  end

  def call
    json = { costing: 'boat',
              locations: @stops.map{|stop| {
                lat: stop.location.latitude,
                lon: stop.location.longitude
              }
              },
              costing_options: {
                boat: {
                  erg_draft: 1.5
                }
              },
              responseFormat: 'geojson'}
    json_string = CGI.escape(JSON.generate(json))
    p json_string
    uri = URI.parse("https://production-autorouter.letsembark.io/route/route?json=#{json_string}")
    request = Net::HTTP::Get.new(uri)
    request.content_type = "application/json"
    request["Authority"] = "production-autorouter.letsembark.io"
    request["Cache-Control"] = "max-age=0"
    request["Sec-Ch-Ua"] = "\"Chromium\";v=\"88\", \"Google Chrome\";v=\"88\", \";Not A Brand\";v=\"99\""
    request["Sec-Ch-Ua-Mobile"] = "?0"
    request["User-Agent"] = "Mozilla/5.0 (Macintosh; Intel Mac OS X 11_2_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.192 Safari/537.36"
    request["Accept"] = "*/*"
    request["Origin"] = "https://appchart.c-map.com"
    request["Sec-Fetch-Site"] = "cross-site"
    request["Sec-Fetch-Mode"] = "cors"
    request["Sec-Fetch-Dest"] = "empty"
    request["Referer"] = "https://appchart.c-map.com/"
    request["Accept-Language"] = "fr-FR,fr;q=0.9,en-US;q=0.8,en;q=0.7"
    req_options = {
      use_ssl: uri.scheme == "https",
    }
    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end
    data = JSON.parse(response.body)
    p data
    data['features'][0]['geometry']['coordinates']
  end
end
