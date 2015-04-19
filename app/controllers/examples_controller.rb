class ExamplesController < ApplicationController
  def index
    @rest_client_response = rest_client_response
    @faraday_response = faraday_response
    @net_http_response = net_http_response
  end

  private

  def rest_client_response
    require 'rest-client'
    RestClient.proxy = ENV["FIXIE_URL"]
    response = RestClient.get("http://welcome.usefixie.com")
  end

  def faraday_response
    require 'faraday'
    conn = Faraday.new(:url => "http://welcome.usefixie.com", :proxy => ENV["FIXIE_URL"])
    response = conn.get
  end

  def net_http_response
    require 'net/http'
    _, username, password, host, port = ENV["FIXIE_URL"].gsub(/(:|\/|@)/,' ').squeeze(' ').split
    uri       = URI("http://welcome.usefixie.com")
    request   = Net::HTTP.new(uri.host, uri.port, host, port, username, password)
    response  = request.get(uri)
  end
end