Rails.application.routes.draw do
  # ログインページのルーティング
  # 名前月ルーティングにすることで, 必要なものだけを加えられる.
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  # 名前付きルーティング.まあ,名前の通り.
  # /help でstatic_pagesのhelpを表示するという意味になる。
  # こうすることで, help_pathでリンクを参照することができる.
  # 利点としては, 変更するのがroutesだけですむので楽.
  get '/help', to: 'static_pages#help'
  get '/signup', to: 'users#new'

  # RESTfulなURLを自動的に生成する
  # REST:操作の対象となるリソース(下記だとuser)をURLを使って表し、それに対してHTTPメソッドを使って操作を行う.
  # 例えばGETではリソースを取得し,PUTでは新しいリソースを登録する.
  # 下記のように書けば, 自動的に生成できる.
  resources :users

  # root:ドメイン(ex.localhost)のみ指定したときに飛ぶページ(トップページにしたいところを設定しておけばおけ.)
  root 'static_pages#home'

end
