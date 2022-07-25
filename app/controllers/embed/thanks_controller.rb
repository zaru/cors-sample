class Embed::ThanksController < ApplicationController
  def show
    response.headers['X-Frame-Options'] = "ALLOW-FROM http://good.example.jp:9000"
  end
end
