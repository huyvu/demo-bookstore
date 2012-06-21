class PageController < ApplicationController
  skip_before_filter :authorize
  def home
    @books = Book.paginate :page =>params[:page], :order =>'created_at desc', :per_page => 4

  end

  def about
  end

  def contact
  end

  def help
  end
end
