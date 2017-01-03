module SessionsHelper
  # ログインとしてuserのidをsessionに保存しておく
  # 引数:user(フォームに入力されたユーザー情報)
  def log_in(user)
    session[:user_id] = user.id
  end
  def remember(user)
    # 永続化するためのtokenを生成.
    user.remember
    # cookies:クッキーで保持しておく値を設定
    # signed:署名付きクッキー.保存される前に,暗号化する.
    # permanent:クッキーを永続化する.(厳密には２０年間保持)
    cookies.permanent.signed[:user_id] = user.id
    # 適当な文字列なので署名はしなくておけ.
    cookies.permanent[:remember_token] = user.remember_token
  end
  # 現在ログインしているユーザの情報を取得する.
  # Rubyは最後に評価された値が返る!!!!(超大事,自分が気持ち悪いと感じる根幹)
  # この場合,current_user(インスタンス変数)かuser(取得できなかったのでnilが入ってる)が返る.
  # ちなみにRubyのreturnは値を返す「タイミング」を指定するときに使う.
  def current_user
    if (user_id = session[:user_id])
      # @current_userがnilのときだけ実行
      # x = x+1 => x += 1と書けるように, @current_user = @current_user || User...が下記のように書ける.
      # findだとエラーがおこるのでfind_byでnilを代入するようにしている.
      @current_user ||= User.find_by(id:user_id)
    # もし一時セッションで保持されていなかったらクッキーを参照する.
    elsif (user_id = cookies.signed[:user_id])
      # ローカル変数にdbから取得したデータを代入(できなかったらnil)
      user = User.find_by(id:user_id)
      # 有効なユーザーかつ正しい永続化用のtokenであればログインする.
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end
  # ユーザがログインしているかを確認(sessionのuser_idの有無で判断)
  def logged_in?
    # nilだったらtrueになるので真偽値を逆転している.
    !current_user.nil?
  end
  # 永続情報を破棄する
  def forget(user)
    # dbからremember_digestを削除
    user.forget
    # cookieから削除
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end
  # ログアウト
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end
end
