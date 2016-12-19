# ADDXXXToYYYと指定することでrakeで自動生成してくれる.
# 自動生成するには, XXXは適当で良いが, YYYはテーブル名(usersならUsersと指定)を書かなければいけない.
class AddColumnsToUsers < ActiveRecord::Migration[5.0]
  def change
    # カラムの変更は1行に1つ
    # 書き方; :(テーブル名), :(カラム名), :(型名)
    add_column :users, :username, :string
    add_column :users, :location, :string
    add_column :users, :about, :text
  end
end
