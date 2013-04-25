Rails.application.routes.draw do

  resources :likes, :only => [] do
    member do
      put 'unlike'
      put 'relike'
    end
  end
  post "likes" => "likes#create", :as => "create_like"
  
end
