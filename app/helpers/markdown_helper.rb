module MarkdownHelper
  class HTMLwithCoderay < Redcarpet::Render::HTML
    def block_code(code, language)
      language = language.split(':')[0]
      case language.to_s
      when 'rb'
        lang = 'ruby'
      when 'js'
        lang = 'JavaScript'
      when 'sql'
        lang = 'SQL'
      when 'yml'
        lang = 'yaml'
      when 'css'
        lang = 'css'
      when 'html'
        lang = 'html'
      when ''
        lang = 'md'
      else
        lang = language
      end
      CodeRay.scan(code, lang).div
    end
  end

  def markdown(text)
    # 画面の入力内容からシンタックスハイライトを作成(with_toc_data: リンクを許可する設定)
    html_render = HTMLwithCoderay.new(with_toc_data: true)
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
        quote: true,
        # ~２つで取り消し線
        strikethrough: true,
        # 下線
        underline: true
    }
    # HTMLwithCoderayの中で既にRedcarpet::Render::HTMLを既に行っているため無効化
    # renderer = Redcarpet::Render::HTML.new(option)
    @markdown = Redcarpet::Markdown.new(html_render, options)
    @markdown.render(text).html_safe
  end
end
