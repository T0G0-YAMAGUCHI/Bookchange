class ToppagesController < ApplicationController
  def index
    @books=Book.all
  end
end
