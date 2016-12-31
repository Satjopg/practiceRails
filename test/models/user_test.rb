require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # setup:テストをする前に実行される. この場合, @userを作成しておく.
  def setup
    # password_confirmation: password確認用の値
    @user = User.new(name: "Example User", mail: "user@example.com", password: "foobar", password_confirmation: "foobar")
  end
  #user test#
  # 作成したuserの有効性を調べる
  test "should be valid" do
    # valid: modelが有効かどうか判断する(validをmodelで宣言していなければtrueが返る)
    # assert: 引数がTrueならOKの旨を表示
    assert @user.valid?
  end

  # user:name test

  # userのnameの存在性をtest.
  # @userのnameを空文字に変更し, テストを失敗させる.
  # assert_not: assertとは逆
  test "name should be present" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  # user:mail test #

  # mailの存在性のテスト
  test "mail should be present" do
    @user.mail = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end
  # mailのフォーマットのテスト(hoge@hogehogeになっているか)
  test "mail validation should reject invalid addresses" do
    # フォーマットが無効なアドレスの配列を宣言
    # %w[]で文字列の配列.各要素はスペースで区切ればおけ
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    # 拡張for文みたいなやつ
    invalid_addresses.each do |invalid_address|
      # userのmailに代入
      @user.mail = invalid_address
      # 無効ならそのアドレスを表示する.
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end
  # メールアドレスの一意性(重複していないか)のテスト
  test "mail addresses should be unique" do
    # (model).dup: 同じ属性のデータを複製する.
    duplicate_user = @user.dup
    # 全て大文字に変更(通常mailは大文字小文字の区別はしない)
    duplicate_user.mail = @user.mail.upcase
    @user.save
    assert_not duplicate_user.valid?
  end
  # 小文字に変換できているかのテスト
  test "mail addresses should be saved as lower-case" do
   mixed_case_mail = "Foo@ExAMPle.CoM"
   @user.mail = mixed_case_mail
   @user.save
   assert_equal mixed_case_mail.downcase, @user.reload.mail
 end

 # user:password test #

 # 空白じゃなくてちゃんと文字列であるかを確認
 test "password should be present (nonblank)" do
   # 多重代入.同時に代入ができる.
   @user.password = @user.password_confirmation = " " * 6
   # presenceがfalseなので,通らなければおけ.
   assert_not @user.valid?
 end
 # 最低文字数がちゃんと判定できているかのtest
 test "password should have a minimum length" do
   @user.password = @user.password_confirmation = "a" * 5
   # 5文字だから通らなければおけ
   assert_not @user.valid?
 end
end
