Rails.application.routes.draw do

  ## -----------
  ## Q-Auth URLS
  ## -----------
  mount QAuthRubyClient::Engine, at: "/q-auth", :as => 'q_auth_ruby_client'

  # ------------
  # Public pages
  # ------------

  root :to => 'public/welcome#home'

  namespace :public do
    resources :events, only: [:index, :show] do
      member do
        post :apply
      end
      resources :career_interests, only: [:show] do
        member do
          get :confirm
        end
      end
    end
  end

  # ------------
  # Admin pages
  # ------------

  namespace :admin do
    resources :events do
      resources :career_interests do
        member do
          get 'download'
        end
      end
    end
  end

  # ------------
  # User pages
  # ------------

  namespace :users do

    # Landing page after sign in
    get   '/dashboard',         to: "dashboard#index",   as:  :dashboard

    resources :events, :only=>[:index, :show] do
      resources :career_interests
    end
    resources :candidates, only: [:show] do
      collection do
        get 'download'
      end
    end
  end

end
