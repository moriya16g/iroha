# -*- coding: utf-8 -*-
require 'tk'

# ファイラウィンドウを扱うクラス
# Author :: Shigeru Moriya <moriya@sarotti.net>
class FilerView < TkCanvas
  
  # ファイラウィンドウをセットアップする
  def setup
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
      TkcText.new(self, 0, 20*i, :text=>'Hello World', :anchor=>'nw', 
                  :fill=>'red', :font=>['ＭＳ 明朝', 20])
    }
  end
  
end
