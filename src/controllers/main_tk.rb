#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
require 'tk'
require File.expand_path(File.dirname(__FILE__) + '/../models/config_model')
require File.expand_path(File.dirname(__FILE__) + '/../models/file_list_model')
require File.expand_path(File.dirname(__FILE__) + '/../views/tk/main')
require File.expand_path(File.dirname(__FILE__) + '/../views/tk/filer_view')

f1 = FileListModel.new("c:/")
f2 = FileListModel.new("c:/")
config = ConfigModel.new
iroha = MainWindowView.new(config, f1, f2)
Tk.mainloop

