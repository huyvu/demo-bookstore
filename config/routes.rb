Demo::Application.routes.draw do


  get "page/home"

  get "page/about"

  get "page/contact"

  get "page/help"

  match '/contact', :to => 'page#contact' 
  match '/about', :to => "page#about", as: 'about'
  match '/help', :to => 'page#help'


  get 'admin' => 'admin#index'
  controller :sessions do
    get  'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end

    resources :users
    resources :orders
    resources :line_items
    resources :carts do
      resources :line_items
    end
    resources :books

    resources :cats

    root to: 'page#home', as: 'home'

  mount Ckeditor::Engine => "/ckeditor"
end
