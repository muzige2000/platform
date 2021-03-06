
AmahiHDA::Application.routes.draw do

  themes_for_rails
  amahi_plugin_routes

  match 'login' => 'user_sessions#new', :as => :login
  match 'logout' => 'user_sessions#destroy', :as => :logout
  match 'user_session/set_first_password/:username' => 'user_sessions#set_first_password', :as => :first_password

  resources :users do
    member do
      put 'toggle_admin'
      put 'update_password'
      put 'update_username'
    end
  end

  resources :shares do
    collection do
      get 'disk_pooling'
      get 'settings'
      put 'toggle_disk_pool_partition'
    end

    member do
      put 'toggle_visible'
      put 'toggle_everyone'
      put 'toggle_readonly'
      put 'toggle_access'
      put 'toggle_write'
      put 'toggle_guest_access'
      put 'toggle_guest_writeable'
      put 'update_tags'
      put 'update_path'
      put 'toggle_disk_pool'
      put 'update_extras'
    end
  end


  resources :apps do
    collection do
      get 'installed'
    end

    member do
      post 'install_via_daemon'
      get 'install_progress'

      post 'uninstall_via_daemon'
      get 'uninstall_progress'

      put 'toggle_in_dashboard'
    end
  end

  resources :user_sessions, :hosts, :aliases, :firewalls

  match 'search/:action' => 'search', :as => :search
  match 'theme/*filename' => 'theme#file'

  root :to => 'front#index'

  match ':controller(/:action(/:id))(.:format)'

  match '*rest' => 'setup#index'
end
