Rails.application.routes.draw do

devise_for :users, path: 'admin', :controllers => { :sessions => "admin/sessions", :registrations => "admin/registrations", :passwords => "admin/passwords" }


  namespace :admin do
    resources :articles do
      resources :comments
      resources :notes
    end 

       
    get '', to: 'dashboard#index', as: '/'
    resources :pages
    resource :profile
    resources :blog_details do
      post 'export_to_json', :on => :collection

    end
    
    resources :settings 
    # do 
    #   post "settings/:id", to: "settings#update", as: :settings
    # end
    post "settings/:id", to: "settings#update", as: :change_settings
    post "settings/:id/edit", to: "settings#edit"
  end
  
  resources :articles, only: [:show, :index] do
    resources :comments    
  end

  get 'feed' => 'articles#feed', as: :feed, :defaults => { :format => 'rss' }


  # resources :pages, only: [:show]
  # get ':id', to: 'pages#show', as: :page
  # resources :pages, :path => 'about'
  get ':id', to: 'pages#show', as: :page
  # Static pages
  #
 resources :user_subscription



  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'articles#index'

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
