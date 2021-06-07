Rails.application.routes.draw do



  scope module: :admin do
    devise_for :admins, controllers: {
      sessions:      'admin/admins/sessions',
      passwords:     'admin/admins/passwords',
      registrations: 'admin/admins/registrations'
    }
  end

  scope module: :public do
    root 'homes#top'
    devise_for :users, controllers: {
      sessions:      'public/users/sessions',
      passwords:     'public/users/passwords',
      registrations: 'public/users/registrations'
    }
  end
end
