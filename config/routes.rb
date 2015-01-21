Rails.application.routes.draw do
  use_doorkeeper

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  concern :timetable do
    get :timetable, on: :member
  end

  root 'pages#index'
  resources :klasses, only: %i(index), path: :classes, concerns: :timetable
  resources :lecturers, only: %i(index), concerns: :timetable
  resources :reschedulings, only: %i(index)

  devise_for :staffs,
    only: [:sessions, :invitations],
    controllers: {
      sessions: 'staffs/sessions',
      invitations: 'staffs/invitations'
    }

  namespace :staffs do
    get 'home' => 'home#home'

    resources :timetables, only: %i(new create)
    resources :klasses, only: %(index), path: :classes, concerns: :timetable
    resources :lecturers, only: %i(index update), concerns: :timetable
    resources :reschedulings, only: %i(new create)
    namespace :reschedulings do
      scope ':category' do
        resources :klasses, only: %(index), path: :classes, concerns: :timetable
        resources :lecturers, only: %(index), concerns: :timetable
      end
    end
    resources :staffs, only: %i(index create) do
      collection { post :invite }
    end
  end

  namespace :api do
    scope :v1 do
      resources :lectures, only: %i(index show)
      resources :klasses, only: %i(index show), path: :classes
      resources :reschedulings, only: %i(index)
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
