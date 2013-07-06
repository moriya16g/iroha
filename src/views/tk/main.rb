# -*- coding: utf-8 -*-
require 'tk'
require File.expand_path(File.dirname(__FILE__) + '/filer_view')

# メインウィンドウを扱うクラス
# Author :: Shigeru Moriya <moriya@sarotti.net>
class MainWindowView
  
  # コンストラクタ
  # ==== args
  # c :: ConfigModel instnace
  def initialize(c)
    root = TkRoot.new {
      title c.main_window_title
      #width c.main_window_size_x
      #height c.main_window_size_y
      minsize 0, 0
      #maxsize c.main_window_size_x, c.main_window_size_y
      resizable 1, 1
      geometry c.main_window_size_x.to_s + 'x' + c.main_window_size_y.to_s + 
        '+' + c.main_window_pos_x.to_s + '+' + c.main_window_pos_y.to_s
    }
    create_double_window(c, root)
  end
  
  # 二画面ウィンドウを生成
  # ====
  # c :: ConfigModel instance
  # parent :: メインウィンドウ
  def create_double_window(c, parent)
    paned1 = TkPanedWindow.new(parent, :orient=>'vertical')
    paned2 = TkPanedWindow.new(paned1, :orient=>'horizontal')
    @left = FilerView.new(paned2, :bg=>c.filer_bg_color)
    @right = FilerView.new(paned2, :bg=>c.filer_bg_color)
    paned2.add @left, @right
    paned2.pack(:fill=>'both', :expand=>true, :side=>'top')
    @buttom = TkCanvas.new(paned1, :bg=>c.filer_bg_color)
    paned1.add paned2, @buttom
    paned1.pack(:fill=>:both, :expand=>true, :side=>'top') 
    @left.setup(c)
    @right.setup(c)
    @left.setup_size(400, 500)
  end
  
end
