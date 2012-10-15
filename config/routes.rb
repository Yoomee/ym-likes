Rails.application.routes.draw do

  resources :likes, :only => [:destroy], :module => 'ym_likes'
  post "likes" => "YmLikes::Likes#create", :as => "create_like"
  match ":resource_type/:resource_id/like" =>  "YmLikes::Likes#create", :as => "create_like_logged_out"
  
end
