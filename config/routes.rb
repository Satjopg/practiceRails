Rails.application.routes.draw do
  # root:ドメイン(ex.localhost)のみ指定したときに飛ぶページ(トップページにしたいところを設定しておけばおけ.)
  root 'static_pages#home'
  # /help でstatic_pagesのhelpを表示するといういみになる。
  # こうすることで, help_pathでリンクを参照することができる.
  # 利点としては, 変更するのがroutesだけですむので楽.
  get '/help', to: 'static_pages#help'
  get '/signup', to: 'users#new'

  # RESTfulなURLを自動的に生成する
  # REST:操作の対象となるリソース(下記だとuser)をURLを使って表し、それに対してHTTPメソッドを使って操作を行う.
  # 例えばGETではリソースを取得し,PUTでは新しいリソースを登録する.
  # 下記のように書けば, 自動的に生成できる.
  resources :users
end
