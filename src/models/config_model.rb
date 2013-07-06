# -*- coding: utf-8 -*-
require 'tk'

# 設定を扱うクラス
# Author :: Shigeru Moriya <moriya@sarotti.net>
class ConfigModel

  # メインウィンドウのタイトル
  attr_reader :main_window_title
  @main_window_title = "iroha Ver.0.1"
  
  # メインウィンドウの画面x方向サイズ
  attr_accessor :main_window_size_x
  
  # メインウィンドウの画面y方向サイズ
  attr_accessor :main_window_size_y
  
  # メインウィンドウの画面x方向位置
  attr_accessor :main_window_pos_x
  
  # メインウィンドウの画面y方向位置
  attr_accessor :main_window_pos_y

  # ファイラ画面の前景色
  attr_accessor :filer_fg_color
  
  # ファイラ画面の背景色
  attr_accessor :filer_bg_color
  
  # ファイラ画面のフォント
  attr_accessor :filer_font
  
  # ファイラ画面のフォントサイズ(ピクセル単位指定)
  attr_accessor :filer_font_size
  
  # ファイラ画面のフォント色
  attr_accessor :filer_font_color
  
  # コンストラクタ
  # ==== args
  # filename :: コンフィグファイル名(nilの場合はデフォルト値を設定する)
  def initialize(filename = nil)
    if filename != nil
      # ToDo コンフィグファイルを読み込み、設定する
    else
      set_default
    end
  end
  
  # デフォルト値を設定する
  def set_default
    @main_window_size_x = 800
    @main_window_size_y = 600
    @main_window_pos_x = 100
    @main_window_pos_y = 100
    
    @filer_fg_color = 'white'
    @filer_bg_color = 'black'
    @filer_font = 'Courier'
    @filer_font_size = '12'
    @filer_font_color = 'white'
  end
  
end

