class Embed::ThanksController < ApplicationController
  def show
    response.headers['X-Frame-Options'] = "ALLOW-FROM http://evil.example.net:9999"
  end
end
