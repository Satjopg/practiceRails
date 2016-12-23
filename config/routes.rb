Rails.application.routes.draw do
  get 'static_pages/home'

  get 'static_pages/help'

  get 'users/index'

  get "users/show" , to: "users#show"
  # :~ でパラメータを取得. パラメーターはparamsに入る.
  # to~ 指定したコントローラーに飛び, #~ ~の処理(アクション)をしろという意味
  get 'users/show/:username', to: 'users#show'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
