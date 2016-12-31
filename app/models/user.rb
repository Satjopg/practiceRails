class User < ApplicationRecord
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
end
