#
#  AppDelegate.rb
#  iroha
#
#  Created by moriya on 2013/07/10.
#  Copyright 2013年 moriya. All rights reserved.
#

class AppDelegate
    attr_accessor :window
    attr_accessor :left_filer
    attr_accessor :right_filer
    attr_accessor :bottom_message
    def applicationDidFinishLaunching(a_notification)
        # Insert code here to initialize your application
        @left_filer.setFrameSize(NSSize.new(500,1000))
        @str = NSAttributedString.new.initWithString("Hello")
        @point = NSPoint.new(0,0)
        @str.drawAtPoint(@point)
    end
end

