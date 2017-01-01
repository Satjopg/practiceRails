module UsersHelper
  # gravatarというプロフィール画像とメールアドレスを結び付けてくれるサービスから画像を取得するメソッド.
  def gravatar_for(user)
    # gravatarではメールアドレスをMD5でハッシュ化してURLを生成する.
    # MD5はDigestライブラリのhexdigestメソッドを使うことで実現できる.
    gravatar_id = Digest::MD5::hexdigest(user[:mail].downcase)
    # URLを生成する
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    # image_tag:画像を生成する(src(省略可):画像へのパス, (options)alt:)
    image_tag(gravatar_url, alt: user[:name], class: "gravatar")
  end
end
