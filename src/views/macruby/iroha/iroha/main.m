//
//  main.m
//  iroha
//
//  Created by moriya on 2013/07/10.
//  Copyright (c) 2013年 moriya. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import <MacRuby/MacRuby.h>

int main(int argc, char *argv[])
{
    return macruby_main("rb_main.rb", argc, argv);
}
