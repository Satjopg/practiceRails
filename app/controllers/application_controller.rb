class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # SessionsHelperのメソッドがどのViewでも利用が可能になる
  include SessionsHelper
end
