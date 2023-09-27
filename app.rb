require "sinatra"
require "sinatra/reloader"
require 'open-uri'

get("/") do
  api_url = "https://api.exchangerate.host/symbols"
  raw_data = URI.open(api_url).read
  parsed_data = JSON.parse(raw_data)
  @symbols = parsed_data.fetch("symbols").keys

  erb(:index)
end

get("/:symbols") do
   @original_currency = params.fetch("from_currency")

    api_url = "https://api.exchangerate.host/symbols"
    raw_data = URI.open(api_url).read
    parsed_data = JSON.parse(raw_data)
    @symbols = parsed_data.fetch("symbols").keys

    erb(:convert1)
end

get("/:symbols/:tocurrency") do
  @original_currency = params.fetch("from_currency")
  @destination_currency = params.fetch("to_currency")

  api_url = "https://api.exchangerate.host/convert?from=#{@original_currency}&to=#{@destination_currency}"
  raw_data = URI.open(api_url).read
  parsed_data = JSON.parse(raw_data)
  
  @exchange_rate = parsed_data.fetch("info").fetch("rate")
  
  erb(:convert2)
end
