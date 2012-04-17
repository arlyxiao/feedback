Feedback::Application.routes.draw do
  
  resources :problem_types

  resources :problem_reports do
    collection do
      post :reply
      post :upload_attachement
    end
    
    member do
    
    end
  end
  resources :problem_reports
  
  match '/simple_captcha(/:action)' => 'simple_captcha', :as => :simple_captcha
 
  # -- 用户登录认证相关 --
  root :to => 'index#index'
  get  '/login'  => 'sessions#new'
  post '/login'  => 'sessions#create'
  get  '/logout' => 'sessions#destroy'
  
  get  '/signup'        => 'signup#form'
  post '/signup_submit' => 'signup#form_submit'
end

 