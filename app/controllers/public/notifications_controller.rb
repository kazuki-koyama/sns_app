class Public::NotificationsController < ApplicationController
  def index
    @notifications = current_user.passive_notifications.includes(:visitor, :visited, :post).page(params[:page]).without_count.per(20)
    @notifications.where(checked: false).each do |notification|
      notification.update_attributes(checked: true)
    end
  end
end
