require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("meteorologist/street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]

    maps_url = "http://maps.googleapis.com/maps/api/geocode/json?address=#{@street_address}"

    maps_parsed_data = JSON.parse(open(maps_url).read)

    @lat = maps_parsed_data["results"][0]["geometry"]["location"]["lat"]

    @long = maps_parsed_data["results"][0]["geometry"]["location"]["lng"]

    darksky_url = "https://api.darksky.net/forecast/56337475e8f3b12f47ac38bd506df480/#{@lat},#{@long}"

    darksky_parsed_data = JSON.parse(open(darksky_url).read)

    @current_temperature = darksky_parsed_data["currently"]["temperature"]

    @current_summary = darksky_parsed_data["currently"]["summary"]

    @summary_of_next_sixty_minutes = darksky_parsed_data["minutely"]["summary"]

    @summary_of_next_several_hours = darksky_parsed_data["hourly"]["summary"]

    @summary_of_next_several_days = darksky_parsed_data["daily"]["summary"]

    render("meteorologist/street_to_weather.html.erb")
  end
end
