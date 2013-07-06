# -*- coding: utf-8 -*-
require 'tk'

# ファイラウィンドウを扱うクラス
# Author :: Shigeru Moriya <moriya@sarotti.net>
class FilerView < TkCanvas
  
  # ファイラウィンドウをセットアップする
  # c :: ConfigModel instance
  def setup(c)
    @fg_color = c.filer_fg_color
    @bg_color = c.filer_bg_color
    @font = c.filer_font
    @font_size = c.filer_font_size
    @font_color = c.filer_font_color
    
    
    self.bind('Configure', proc{resize})
    set_scrollbar
    set_scroll_region(1000) #ToDo
  end

  # ファイラウィンドウのサイズを調整する
  # 全てのウィンドウからこのメソッドを呼ぶと全体サイズが
  # 矛盾することに注意すること。
  # ==== args
  # x :: x方向のサイズ
  # y :: y方向のサイズ
  def setup_size(x, y)
    self.width = 400 #ToDo
    self.height = 500 #ToDo
  end
  
  # 非表示も含めたウィンドウサイズの高さ設定
  # ==== args
  # y :: 非表示も含めたウィンドウのy方向サイズ
  def set_scroll_region(y)
    @scr.unpack
    scrollregion [0, 0, self.width, y]
    if y > self.height
      set_scrollbar
    end
  end
  
  # スクロールバーを表示する
  def set_scrollbar
    @scr = TkScrollbar.new(self).pack(:fill=>'y', :side=>'right')
    self.yscrollbar @scr
  end
  
  # ウィンドウの描画をクリアする
  def clear
    self.delete('all')
  end

  # ウィンドウサイズが変更されたときの処理
  def resize
    clear
    (300/20).times {|i|
      TkcText.new(self, 12*i, 12*i, :text=>'Hello World', :anchor=>'nw', 
                  :fill=>@font_color, :font=>[@font, @font_size])
    }
  end
  
end
