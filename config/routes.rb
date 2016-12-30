Rails.application.routes.draw do
  # root:ドメイン(ex.localhost)のみ指定したときに飛ぶページ(トップページにしたいところを設定しておけばおけ.)
  root 'static_pages#home'
  # /help でstatic_pagesのhelpを表示するといういみになる。
  # こうすることで, help_pathでリンクを参照することができる.
  # 利点としては, 変更するのがroutesだけですむので楽.
  get '/help', to: 'static_pages#help'
  get '/signup', to: 'users#new'

  get "users/show" , to: "users#show"
  # :~ でパラメータを取得. パラメーターはparamsに入る.
  # to~ 指定したコントローラーに飛び, #~ ~の処理(アクション)をしろという意味
  get 'users/show/:username', to: 'users#show'

  get 'users/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
