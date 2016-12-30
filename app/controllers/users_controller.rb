# coding:UTF-8
class UsersController < ApplicationController
  def index
  end

  def show
    # @変数はインスタンス変数. クラス内でのみアクセス可能.
    # ハッシュ(連想配列)の生成
    @user = Hash.new { |hash, key| raise(IndexError, "user[#{key}] has no value")}
    # find_by: 指定したカラムから, 当てはまったものの(最初の１件目の)情報を返す。
    # 引数: (カラム名 => 探す値)
    @user = User.find_by(:username => params[:username])
    if @user.nil? then
      nonparameter
    end
  end

  def new
  end

  def nonparameter
    @user = Hash.new { |hash, key| raise(IndexError, "user[#{key}] has no value")}
    @user[:name] = "No User"
    @user[:username] = "noname"
    @user[:mail] = "hoge@nouser.jp"
    @user[:location] = "no location"
    @user[:about] = "いません"
  end
end
