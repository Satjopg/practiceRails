class UsersController < ApplicationController
  def index
  end

  def show
    # ハッシュ(連想配列)の生成
    @user = Hash.new { |hash, key| raise(IndexError, "user[#{key}] has no value")}
    @user = User.find_by(:username => params[:username])
  end
end
