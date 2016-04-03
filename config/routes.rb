Rails.application.routes.draw do
  resources :users, only: [:create, :new, :show]
  resource :session, only: [:create, :new, :destroy]

  resources :hubs do
    resources :posts, except:[:index] do
      post "upvote", on: :member
      post "downvote", on: :member
      resources :comments, except:[:index] do
        post "upvote", on: :member
        post "downvote", on: :member
      end
    end
  end

end
