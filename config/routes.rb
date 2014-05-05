PublicStand::Application.routes.draw do
  subdomain_regex = /[^(staging)(www)]+/

  get 'twilio_outbound_voice_callback' => 'twilio_callbacks#outbound_voice'
  get 'twilio_voice_status_callback' => 'twilio_callbacks#voice_status'
  get 'login' => 'sessions#new'
  get 'log_out' => 'sessions#destroy'
  get 'sign_up' => 'authentications#new'
  get 'home' => 'root#home'
  get 'dear-internet' => 'root#dear_internet'

  resources :authentications, only: [:new, :create]
  resources :campaign_targets, only: [] do
    resources :phone_calls, only: [:create]
  end
  resources :phone_calls, only: [] do
    resource :phone_call_feedback, only: [:create], controller: :phone_call_feedback
    get '/analytics', controller: 'campaigns', action: 'edit', as: 'vanity_edit_organization_campaign'
  end
  resources :email_subscribers, only: [:create]
  resources :organizations, except: [:delete] do
    resources :campaigns, except: [:delete]
  end
  resources :pictures, only: [:edit] do
    get 's3_update' => 'pictures#s3_update'
  end
  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :show]

  constraints subdomain: subdomain_regex do
    get '/', controller: 'organizations', action: 'show', as: 'vanity_organization'
    get '/edit', controller: 'organizations', action: 'edit', as: 'vanity_edit_organization'

    get '/campaigns/new', controller: 'campaigns', action: 'new', as: 'vanity_new_organization_campaign'
    get '/:campaign_vanity/edit', controller: 'campaigns', action: 'edit', as: 'vanity_edit_organization_campaign'
    get '/:campaign_vanity/analytics', controller: 'campaigns', action: 'analytics', as: 'vanity_analytics_organization_campaign'
    get '/:campaign_vanity', controller: 'campaigns', action: 'show', as: 'vanity_organization_campaign'
  end

  root 'root#home'

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
