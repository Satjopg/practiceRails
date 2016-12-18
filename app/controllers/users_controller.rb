class UsersController < ApplicationController
  def index
  end

  def show
    # ハッシュ(連想配列)の生成
    @user = Hash.new { |hash, key| raise(IndexError, "user[#{key}] has no value")}
    if params[:username] == "satoru" then
        # :(文字列)はシンボル。文字列とは違い実際は数値として認識されている。(参照が文字列より早いらしい)
      @user[:name] = "Satoru Murakami"
      @user[:username] = "satoru"
      @user[:location] = "IKUTA"
      @user[:about] = "Hello, World!!"
    else
      @user[:name] = "NO, NAME"
      @user[:username] = params[:username]
      @user[:location] = "NO LOCATION"
      @user[:about] = "パラメーター取れたああ!!"
    end
  end
end
