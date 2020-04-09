module MarkdownHelper
  def markdown(text)
    unless @markdown
      options = {
        # htmlのアクションを無効にうる
        filter_html: true,
        # 行末に２つスペースを入れなくても改行できるようになる
        hard_wrap: true,
        # <> で囲まなくてもリンクとして機能させる
        autolink: true, 
        # プログラム言語に変換されなくなる
        no_intra_emphasis: true,
        # PHP-markdown形式でテーブルを変換する
        tables: true,
        # ---　または '''とするとコードと識別されるようになる
        fenced_code_blocks: true,
        # 引用符を解析
        quote: true
      }
      renderer = Redcarpet::Render::HTML.new(options)
      @markdown = Redcarpet::Markdown.new(renderer)
    end

    @markdown.render(text).html_safe
  end
end