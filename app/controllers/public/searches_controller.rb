class Public::SearchesController < ApplicationController
  def search
    if (params[:keyword]) == '#' || (params[:keyword]) == ""
      redirect_back(fallback_location: root_path)
    elsif (params[:keyword]).include?('#')
      @posts = Hashtag.search(params[:keyword]).order('created_at DESC')
      @hashtag = (params[:keyword])
    elsif (params[:keyword]).include?('#') && @posts.nil?
      @hashtag = (params[:keyword])
    else
      @users = User.search(params[:keyword]).order('created_at DESC')
      @keyword = (params[:keyword])
    end
  end
end
