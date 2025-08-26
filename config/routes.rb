Rails.application.routes.draw do
    # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
    mount_devise_token_auth_for 'User', at: '/api/v1/auth', controllers: {
      registrations: 'api/v1/registrations',
      sessions: 'api/v1/sessions',
      passwords: 'api/v1/passwords'
    }

    namespace :api do
      namespace :v1, defaults: { format: :json } do
        resources :permissions
        resources :roles
        resources :team_members
        resources :minutes
        resources :monthly_schedules
        resources :manuals
        resources :file_uploads
        resources :folders
        resources :attendance_confirmations
        resources :meetings
        resources :task_comments
        resources :tasks
        resources :teams
        resources :attendances
        resources :events
        resources :members do
          member do
            patch :reactivate
          end
        end
      end
    end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
