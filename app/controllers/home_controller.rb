class HomeController < ApplicationController
  def index
  end
  def health
    render text: 'ok'
  end
end
