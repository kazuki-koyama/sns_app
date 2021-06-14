class Public::SearchesController < ApplicationController
  def search
    if (params[:keyword]) == '#' || (params[:keyword]) == ""
      redirect_back(fallback_location: root_path)
    elsif (params[:keyword]).include?('#')
      @posts = Hashtag.search(params[:keyword]).order('created_at DESC')
      # 完全一致以外はリダイレクト
      redirect_back(fallback_location: root_path) if @posts[0].nil?
      @hashtag = (params[:keyword])
      @comment = Comment.new
    else
      @users = User.search(params[:keyword]).order('created_at DESC')
    end
  end
end
