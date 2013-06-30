# -*- coding: utf-8 -*-
require File.expand_path(File.dirname(__FILE__) + '/file_model')

# ファイルリストを扱うクラス
# Authors :: Shigeru Moriya <moriya@sarotti.net>
class FileListModel
  
  # コンストラクタ
  # ==== args
  # path :: ファイルリストを取得するディレクトリ
  def initialize(path)
    @path = path
    list_up()
  end

  # ファイル名順でファイルリストをソートする
  # ==== args
  # dir :: ディレクトリを特別扱いするか?
  # reverse :: 逆順にソートするか?
  def sort_in_filename(dir = true, reverse = false)
    dir_list = []
    if dir
      dir_list = get_dirs
      dir_list = dir_list.sort{|a, b| a.filename <=> b.filename}
      file_list = get_files
    else
      file_list = @list.clone
    end
    file_list = file_list.sort{|a, b| a.filename <=> b.filename}
    if reverse
      @list = dir_list.reverse + file_list.reverse
    else
      @list = dir_list + file_list
    end
  end

  # 拡張子順でファイルリストをソートする
  # ==== args
  # dir :: ディレクトリを特別扱いするか?
  # reverse :: 逆順にソートするか?
  def sort_in_extention(dir = true, reverse = false)
    dir_list = []
    if dir
      dir_list = get_dirs
      dir_list = dir_list.sort{|a, b| a.filename <=> b.filename}
      file_list = get_files
    else
      file_list = @list.clone
    end
    file_list = file_list.sort{|a, b| 
      if a.extention.empty? and b.extention.empty?
        a.filename <=> b.filename
      elsif a.extention.empty? and b.extention.empty? == false
        -1
      elsif a.extention.empty? == false and b.extention.empty?
        1
      else
        a.extention <=> b.extention
      end
    }
    if reverse
      @list = dir_list.reverse + file_list.reverse
    else
      @list = dir_list + file_list
    end
  end
 
  # サイズ順でファイルリストをソートする
  # ==== args
  # dir :: ディレクトリを特別扱いするか?
  # reverse :: 逆順にソートするか?
  def sort_in_size(dir = true, reverse = false)
    dir_list = []
    if dir
      dir_list = get_dirs
      dir_list = dir_list.sort{|a, b| a.size <=> b.size}
      file_list = get_files
    else
      file_list = @list.clone
    end
    file_list = file_list.sort{|a, b| a.size <=> b.size}
    if reverse
      @list = dir_list.reverse + file_list.reverse
    else
      @list = dir_list + file_list
    end
  end

  # タイムスタンプ順でファイルリストをソートする
  # ==== args
  # dir :: ディレクトリを特別扱いするか?
  # reverse :: 逆順にソートするか?
  def sort_in_timestamp(dir = true, reverse = false)
    dir_list = []
    if dir
      dir_list = get_dirs
      dir_list = dir_list.sort{|a, b| a.timestamp <=> b.timestamp}
      file_list = get_files
    else
      file_list = @list.clone
    end
    file_list = file_list.sort{|a, b| a.timestamp <=> b.timestamp}
    if reverse
      @list = dir_list.reverse + file_list.reverse
    else
      @list = dir_list + file_list
    end
  end

  def print
    @list.size.times{|i|
      p @list[i]
    }
  end
  
  # ファイルリストを取得・更新する
  def list_up
    @list = []
    Dir.glob(@path + '/.*').each{|f|
      @list << FileModel.new(f)
    }
    Dir.glob(@path + '/*').each{|f|
      @list << FileModel.new(f)
    }
  end
  private :list_up
  
  # ファイルリストからディレクトリのみを抽出
  # ==== return
  # ディレクトリのみのリスト
  def get_dirs
    return @list.select{|f| f.is_dir == true}
  end
  private :get_dirs
  
  # ファイルリストからファイルのみを抽出
  # ==== return
  # ファイルのみのリスト
  def get_files
    return @list.select{|f| f.is_dir == false}
  end
  private :get_files
end
