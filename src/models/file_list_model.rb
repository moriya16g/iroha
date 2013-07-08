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

  # ファイルリストの数を返す
  # ==== return
  # ファイルリストの数
  def size
    return @list.size
  end
  
  # ファイルリストをString型で返す
  # ==== args
  # idx :: インデックス
  # x :: x方向文字数
  # ==== return
  # String
  def get_string(idx, x)
    str = get_filename(idx, x)
    if str.size < 15+6
      return str
    end
    str[-15-6, 6] = get_extention(idx) + ' '
    str[-15, 15] = get_date(idx)
    return str
  end
 
  # サイズもしくはディレクトリ文字列を文字列で返す
  # ==== args
  # idx :: インデックス
  # ==== return
  # サイズもしくはディレクトリ文字列
  def get_extention(idx)
    if @list[idx].is_dir
      return " <DIR>"
    else
      if @list[idx].size > 1024 ** 4
        return sprintf("%5.1fT", @list[idx].size / (1024.0 ** 4))
      elsif  @list[idx].size > 1024 ** 3
        return sprintf("%5.1fG", @list[idx].size / (1024.0 ** 3))
      elsif  @list[idx].size > 1024 ** 2
        return sprintf("%5.1fM", @list[idx].size / (1024.0 ** 2))
      elsif  @list[idx].size > 1024 ** 1
        return sprintf("%5.1fK", @list[idx].size / (1024.0 ** 1))
      else
        return sprintf("%5dB", @list[idx].size.to_i)
      end
    end
  end

  # 日付を文字列で返す
  # ==== args
  # idx :: インデックス
  # ==== return
  # 日付の文字列
  def get_date(idx)
   return @list[idx].timestamp.strftime("%y/%m/%d %H:%M")
  end

  # ファイル名と拡張子を文字列で返す
  # ==== args
  # idx :: インデックス
  # x :: x方向文字数
  # ==== return
  # ファイル名の文字列
  def get_filename(idx, x)
    name = ''
    ext = '    '
    if !(@list[idx].is_dir)
      if @list[idx].extention.size <= 5
        ext = @list[idx].extention
      else
        name = @list[idx].extention
      end
    end
    name = @list[idx].filename + name
    
    str = ' '*x
    str[0, name.size] = name
    if str.size < 15+6+ext.size+2
      return str
    end
    str[-15-6-ext.size-2, ext.size] = ext
    str[-15-6-2, 2] = '  '
    return str
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
