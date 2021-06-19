class Public::SearchesController < ApplicationController
  def search
    if (params[:keyword]) == '#' || (params[:keyword]) == ""
      redirect_back(fallback_location: root_path)
    elsif (params[:keyword]).include?('#')
      @posts = Hashtag.search(params[:keyword]).order('created_at DESC').page(params[:page]).without_count.per(10)
      @hashtag = (params[:keyword])
    elsif (params[:keyword]).include?('#') && @posts.nil?
      @hashtag = (params[:keyword])
    else
      @users = User.search(params[:keyword]).order('created_at DESC').page(params[:page]).without_count.per(10)
      @keyword = (params[:keyword])
    end
  end
end
