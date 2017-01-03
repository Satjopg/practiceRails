class User < ApplicationRecord
  # アクセス可能なインスタンス変数を作成
  attr_accessor :remember_token
  # before_save{}: saveの前にブロックの中身を実行する.今回はmailを小文字に変更する.
  before_save { mail.downcase! }
  # 正規表現: 「/\A...\z/」で正規表現を書ける.
  # iは大文字小文字を無視するoption
  VALID_MAIL_REGLEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  # validates:有効かどうかの条件.下の場合, nameがなければダメという条件を加えている.
  validates :name, presence: true, length: { maximum: 50 }
  # mailの場合も同じ(lengthはその名の通り長さ制限)
  # formatは正規表現にそった通りになっているかを判断, uniquenessは重複を許すか許さないかを指定(case_sensitiveで大文字小文字の判定を行わない)
  validates :mail, presence: true, length: { maximum: 255 }, format: { with: VALID_MAIL_REGLEX }, uniqueness: { case_sensitive: false }
  # この関数を呼び出すことで,password_digestのカラムにハッシュ関数で変換されたパスワードを保存できる.
  has_secure_password
  # passwordの最低文字数の指定と,空白じゃないこと(presence:存在性)を条件として加える.
  validates :password, length: { minimum: 6 }, presence: true

  # 引数をハッシュ化する
  def User.digest(string)
    # ハッシュ関数のコストを定義(コストが大きいほどハッシュからオリジナルを計算するのが困難になる.)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    # Passwordクラスのメソッドを使用(stringをハッ.シュ化する)
    BCrypt::Password.create(string, cost: cost)
  end

  # ランダムなトークン(base64)を返す
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # 永続セッション(ブラウザを切ってもログイン情報を保持している)のためにユーザーをdbに登録する.
  def remember
    # selfとしないとremember_tokenを勝手に作ってしまうので注意.
    self.remember_token = User.new_token
    # remember_digestにremember_tokenを書き込む.(base64のトークンをハッシュ化して保存する)
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # 渡されたトークンがダイジェストと一致したらtrueを返す
  def authenticated?(remember_token)
    # remember_digestに値がなければ認証失敗として返す.
    return false if remember_digest.nil?
    # 自身が持っているremember_digestと送られてきたremember_tokenと比較をしている.
    # BCryptでハッシュ化したものは復号化できない.なのでis_passwordを使用することで,引数がハッシュ化されたものと比較を行う事ができる.
    # (is_passwordを使えるようにbcyrptのPasswordクラスのオブジェクトを定義している.)
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # (永続化された)userのログイン情報を破棄する
  def forget
    update_attribute(:remember_digest, nil)
  end
end
