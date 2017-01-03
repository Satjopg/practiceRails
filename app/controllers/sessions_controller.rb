class SessionsController < ApplicationController
  def new
  end

# セッションを生成する(ログインの実行)
  def create
    # DBから入力されたmailを基にデータを取得する.
    # フォームに入力された情報はパラメータのsessionに格納されている.(sessionは自分で決めた値.)
    user = User.find_by(mail: params[:session][:mail].downcase)
    # user情報がある(nilはfalseと判断される)かつ,userのパスワードが一致したらおけ
    # authenticate: bcyrptのメソッド.引数の文字列(今回はパスワード)をハッシュ化して,dbのpassword_digestと比較して
    # 同じなら登録してある情報(userの情報全て)を返し,違ったらfalseを返す.
    # rubyの場合, nil or false以外はtrueと判断されるのでauthenticateで真偽判定ができる.
    if user && user.authenticate(params[:session][:password])
      # ログイン成功時
      # user情報をsessionで保持(メソッド自体はhelperに定義)
      log_in user
      # 3項演算.評価値がtrueの時左,falseの時は右.
      # 論理値? ?何かをする :別のことをする
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      # ユーザー情報を保持しておくために永続セッションを作成
      remember(user)
      # 取得したuserのページに飛ぶ
      redirect_to user
    else
      # 失敗時
      # 状態とメッセージを送ることでlayoutで設定していたもの(application.html.erb参照)に反映される.
      # 状態はBootStrapで決められたものを使っているので状態に応じたデザインに勝手に変わる.(すげー)
      # flashがnowの場合遷移先のViewでのみメッセージが表示される.
      flash.now[:danger] = "メールアドレスかパスワードを間違っているぞ"
      # newに対応したviewを表示してくれる(この場合はログイン画面に戻ることになる.)
      render "new"
    end
  end

# sessionを壊す,つまりログアウト
  def destroy
    # 現在ログインしているユーザーがいる時のみlog_outを行う.
    log_out if logged_in?
    # ホームをひらく
    redirect_to root_url
  end

end
