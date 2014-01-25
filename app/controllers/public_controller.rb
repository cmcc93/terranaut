class PublicController < ApplicationController

  layout 'application'

  def index
    list
    render('list')
  end

  def list

  end

end
