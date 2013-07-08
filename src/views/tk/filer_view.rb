# -*- coding: utf-8 -*-
require 'tk'

# ファイラウィンドウを扱うクラス
# Author :: Shigeru Moriya <moriya@sarotti.net>
class FilerView < TkCanvas
  
  # ファイラウィンドウをセットアップする
  # ==== args
  # c :: ConfigModel instance
  # f :: FileListModel instance
  def setup(c, f)
    @x = 0
    @y = 0
    @f = f
    
    @fg_color = c.filer_fg_color
    @bg_color = c.filer_bg_color
    @font = c.filer_font
    @font_size = c.filer_font_size
    @font_color = c.filer_font_color
    
    self.bind('Configure', proc{resize})
    set_scrollbar
    set_scroll_region(@f.size * @font_size.to_i) 
    
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
    self.scrollregion [0, 0, TkWinfo.width(self), y]
    if y > self.height
      set_scrollbar
    end
  end
  private :set_scroll_region
  
  # スクロールバーを表示する
  def set_scrollbar
    @scr = TkScrollbar.new(self).pack(:fill=>'y', :side=>'right')
    self.yscrollbar @scr
  end
  private :set_scrollbar
  
  # ウィンドウの描画をクリアする
  def clear
    self.delete('all')
  end
  private :clear

  # ウィンドウサイズが変更されたときの処理
  def resize
    x , y = calc_text_count
    if @x == x
      return
    else
      clear
      @x = x
      @y = y
    end
     
    (@f.size).times {|idx|
      TkcText.new(self, 0, idx * @font_size.to_i, 
                  :text=>@f.get_string(idx, x), :anchor=>'nw', 
                  :fill=>@font_color, :font=>[@font, @font_size])
    }  
  end
  private :resize
  
  # 画面サイズから表示できるテキストの文字数を算出
  # ==== return
  # x :: x方向の文字数
  # y :: y方向の文字数
  def calc_text_count
    x = TkWinfo.width(self) / @font_size.to_i
    y = TkWinfo.height(self) / @font_size.to_i
    return x, y
  end
  private :calc_text_count
  
end
