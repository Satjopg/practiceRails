module SessionsHelper
  # ログインとしてuserのidをsessionに保存しておく
  # 引数:user(フォームに入力されたユーザー情報)
  def log_in(user)
    session[:user_id] = user.id
  end
  # 現在ログインしているユーザの情報を取得する.
  def current_user
    # @current_userがnilのときだけ実行
    # x = x+1 => x += 1と書けるように, @current_user = @current_user || User...が下記のように書ける.
    @current_user ||= User.find_by(id: session[:user_id])
  end
  # ユーザがログインしているかを確認(sessionのuser_idの有無で判断)
  def logged_in?
    # nilだったらtrueになるので真偽値を逆転している.
    !current_user.nil?
  end
  # ログアウト
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
end
