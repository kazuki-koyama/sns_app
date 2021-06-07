Rails.application.routes.draw do

  scope module: :public do
    root 'homes#top'
  end
end
