Rails.application.routes.draw do

  mount RedactorRails::Engine => '/redactor_rails'
  
  
  # get '/login', :to => 'accounts#new', :as => :login

  # get '/logout', :to => 'accounts#destory'

  # get '/auth/:provider/callback' => 'accounts#create_with_fb'
  # get '/console/auth/:provider/callback', to: 'sessions#create_with_fb'
  # get '/console/auth/failure', :to => 'accounts#failure'
  # devise_for :accounts, :controllers => { :omniauth_callbacks => "accounts" }
  root :to => "consoles#index"

  resources :consoles do
     collection do
      get :login
      post :fblogin
      post :googlelogin
      post :signin
      get :logout
      get :aboutus
      get :test
      get :subscription
      get :templateindex
      get :testtemplate
      get :notice
    end
  end
  resources :accounts do
     collection do
      get :register
      get :fbregister
      get :googleregister
      get :login
      get :console_edit
      post :signin
      get :logout
      get :test
      get :myaccount
    end
  end
  resources :account_levels do
    collection do
    end
  end
  resources :specialoffers do
    collection do
      get :select_product
      post :insertproduct
      get :index_old
      post :add_to_salecart
    end
  end
  resources :newsboards do
    collection do
    end
  end
  resources :newsletters do
    collection do
    end
  end
    resources :orders do
     collection do
      get :usercheckpay
      get :orderdetail
      get :confirmpay
      get :confirmdelivery
      get :takeproduct
      get :orderdone
      post :usercheckpay_update
      get :checkorder

    end
  end
  resources :brands do
     collection do
    end
  end

  resources :products do
    collection do
      get :console_index
      get :list
      get :progressbar
      get :outofstock
      get :del_register
      get :copy
      post :confirm, :to => :confirmed
      post :add_to_shoppingcart
      get :shoppingcart
      get :shoppingcart_del
      get :shoppingcart_plus
      get :shoppingcart_minus
      get :sellcart_del
      get :newlist
      get :products_template
      get :shopprocess
      get :register
      get :edit_productname
      get :edit_option_surplus
      get :edit_option_price
      get :edit_option_name
      post :product_register
      post :upload_images_del
    end
  end
    resources :type_ones do
    collection do
      get :type_two_get
      get :type_three_get
      get :progressbar
      post :type_two_del
      post :type_three_del
    end
  end
  resources :deliveries do
    collection do
      get :progressbar
      get :index_old
    end
  end
  resources :payments do
    collection do
      get :progressbar
    end
  end
  resources :messages do
    collection do
      get :product_message
      get :order_message
      get :progressbar
      post :reply
    end
  end
  resources :product_messages do
    collection do
      post :reply
    end
  end
  resources :order_messages do
    collection do
      post :reply
    end
  end
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
