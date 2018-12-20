Rails.application.routes.draw do

  mount_devise_token_auth_for 'User', at: 'auth'
  resources :roles, except: [:new, :edit]

  scope path: "/api", as: :api, defaults: {format: :json} do
    resources :books, except: [:new, :edit]
    resources :resumes, except: [:new, :edit]
    resources :bookmarks, except: [:new, :edit]
    resources :annotations, except: [:new, :edit]
    resources :group_members, except: [:new, :edit]
    resources :reading_groups, except: [:new, :edit]

    get '/search', to: 'annotations#search'
  end

end
