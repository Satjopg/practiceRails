module ApplicationHelper
# railsではHelperモジュールを自動的にinclude(:外部ファイルを使えるようにすること)してくれるので
# わざわざrequireなどしなくても,　どこからでも呼び出しが可能
  def full_title(page_title = "")
    base_title = "First App"
    # empty?:オブジェクトは存在しているけどその中身の有無を判断
    if page_title.empty?
    # 暗黙の戻り値(returnなくても呼び出し元に返ってくれる...)
      base_title
    else
      page_title + "|" + base_title
    end
  end
end
