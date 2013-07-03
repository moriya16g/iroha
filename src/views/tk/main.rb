#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
require 'tk'
require File.expand_path(File.dirname(__FILE__) + '/filer_view')

# メインウィンドウを扱うクラス
# Author :: Shigeru Moriya <moriya@sarotti.net>
class MainWindowView
  
  # コンストラクタ
  # ==== args
  # title :: メインウィンドウのタイトル
  # size_x :: メインウィンドウのx方向サイズ
  # size_y :: メインウィンドウのy方向サイズ
  # pos_x :: メインウィンドウのx方向位置
  # pos_y :: メインウィンドウのy方向位置
  def initialize(title = 'iroha', 
                 size_x = 800, size_y = 600, 
                 pos_x = 200, pos_y = 100)
    root = TkRoot.new {
      title title
      #width size_x
      #height size_y
      minsize 0, 0
      #maxsize size_x, size_y
      resizable 1, 1
      geometry size_x.to_s + 'x' + size_y.to_s + 
        '+' + pos_x.to_s + '+' + pos_y.to_s
    }
    create_double_window(root)
  end
  
  # 二画面ウィンドウを生成
  # ==== 
  def create_double_window(parent)
    paned1 = TkPanedWindow.new(parent, :orient=>'vertical')
    paned2 = TkPanedWindow.new(paned1, :orient=>'horizontal')
    @left = FilerView.new(paned2, :bg=>'black')
    @right = FilerView.new(paned2, :bg=>'black')
    paned2.add @left, @right
    paned2.pack(:fill=>'both', :expand=>true, :side=>'top')
    @buttom = TkCanvas.new(paned1, :bg=>'black')
    paned1.add paned2, @buttom
    paned1.pack(:fill=>:both, :expand=>true, :side=>'top') 
    @left.setup
    @right.setup
    @left.setup_size(400, 500)
  end
  
end


iroha = MainWindowView.new
Tk.mainloop

