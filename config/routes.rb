Rails.application.routes.draw do
  root to: 'page#index'
  get 'page/index'
  devise_for :users
  # get 'loader/new'
  # get 'loader/create'
  # get 'loader/index'
  resources :loader
  resources :uploads
  resources :realcosts
  resources :weathers
  resources :photos
  resources :qaqcs
  resources :equipment
  resources :collaborators
  # resources :details
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :measures
      
  # resources :cs_users do 
  #   resources :projects do
  #     resources :activities do
  #       resources :reports do
  #         resources :details
  #       end
  #     end
  #   end  
  #   resources :enterprises
  # end
  
  resources :users do 
    resources :projects do
      resources :activities do
        resources :reports do
          resources :details do
            resources :observations
          end 
        end
      end
    end  
    resources :enterprises
  end
end
