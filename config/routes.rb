Rails.application.routes.draw do

  resources :likes, :only => [:destroy], :module => 'ym_likes'
  post "likes" => "YmLikes::Likes#create", :as => "create_like"
  
end
