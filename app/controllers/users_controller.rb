# coding:UTF-8
class UsersController < ApplicationController
  def index
  end

  def show
    # @変数はインスタンス変数. クラス内でのみアクセス可能.
    # ハッシュ(連想配列)の生成
    @user = Hash.new { |hash, key| raise(IndexError, "user[#{key}] has no value")}
    # find: データをidから参照して取得する
    # find_by: 指定したカラムから, 当てはまったものの(最初の１件目の)情報を返す。
    # 引数: (カラム名 => 探す値)
    @user = User.find(params[:id])
    if @user.nil? then
      nonparameter
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # 保存の成功をここで扱う。
      # flash:主に簡易的なメッセージを通知するために使う.この場合は, ログイン成功時に表示するという意味.
      # flashの表示自体は, application.html.erb内に記述
      flash[:success] = "Welcome to the Sample App!"
      # 成功したら生成したユーザーページに飛ぶ
      redirect_to @user
    else
      render 'new'
    end
  end

  def nonparameter
    @user = Hash.new { |hash, key| raise(IndexError, "user[#{key}] has no value")}
    @user[:name] = "No User"
    @user[:username] = "noname"
    @user[:mail] = "hoge@nouser.jp"
    @user[:location] = "no location"
    @user[:about] = "いません"
  end

# パラメータを外部から見られないようにprivateで定義(Strong Parameter)

  private

    def user_params
      # user属性であることを必須とする.
      # permit以降にハッシュが持つキーを定義しておく(無視しないものだけでおけ.)
      params.require(:user).permit(:name, :mail, :password,
                                   :password_confirmation)
    end
end
