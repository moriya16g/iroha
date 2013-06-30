# -*- coding: utf-8 -*-

# ファイルリストを扱うクラス
# Author :: Shigeru Moriya <moriya@sarotti.net>
class FileModel

  attr_reader :is_dir, :filename, :extention, :size, :timestamp
  
  # コンストラクタ
  # ==== args
  # f :: ファイル名
  def initialize(f)
    @is_dir = is_dir?(f)
    @timestamp = get_timestamp(f)
    if @is_dir
      @filename = get_dirname(f)
      @extention = ""
      @size = 0
    else
      @filename = get_filename(f)
      @extention = get_extention(f)
      @size = get_size(f)
    end
  end

  # ディレクトリかどうか
  # ==== args
  # f :: 調べるファイル・ディレクトリ
  # ==== return
  # true :: ディレクトリである
  # false :: ファイルである
  def is_dir?(f)
    return File::stat(f).directory?
  end
  private :is_dir?

  # ファイル名を取得
  # ==== args
  # f :: 調べるファイル
  # ==== return
  # ファイル
  def get_filename(f)
    return File::basename(f, '.*')
  end
  private :get_filename

  # ディレクトリ名を取得
  # ==== args
  # d :: 調べるディレクトリ
  # ==== return
  # ディレクトリ名
  def get_dirname(d)
    return File::basename(d)
  end
  private :get_dirname
  
  # 拡張子を取得
  # ==== args
  # f :: 調べるファイル
  # ==== return
  # 拡張子
  def get_extention(f)
    return File::extname(f)
  end
  private :get_extention

  # ファイルサイズを取得
  # ==== args
  # f :: 調べるファイル
  # ==== return
  # ファイルサイズ
  def get_size(f)
    return File::stat(f).size()
  end
  private :get_size

  def get_timestamp(f)
    return File::stat(f).mtime()
  end
end
