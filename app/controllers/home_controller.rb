class HomeController < ApplicationController
  def index
  end
  def health
    render plain: 'ok'
  end
end
