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
      # 自動的にログインする.
      log_in @user
      # 成功したら生成したユーザーページに飛ぶ
      # redirect_to @user == redirect_to "/users/#{@user.id}"と考えておけ.
      # ただしこれはモデルをroutesでresourcesで宣言している必要がある.
      # これは厳密に言えば,redirect_to @user が redirect_to user_url(id: @user.id)とuser_urlを利用しているからである.
      # (名前付きルーティングで設定しただけでは生成されないので注意.)
      redirect_to @user
    else
      render 'new'
    end
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
