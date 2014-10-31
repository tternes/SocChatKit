//
//  main.m
//  socsocchatkitdemo
//
//  Created by Thaddeus Ternes on 10/29/14.
//  Copyright (c) 2014 Thaddeus Ternes. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SCKDemoBot.h"

#define kToken  @"aff9ed67-a76d-4748-9a20-32e4bf1ed061"
#define kOffice @"7m3v6290bob68c3w46atjx92"


int main(int argc, const char * argv[]) {
    @autoreleasepool
    {
        SCKDemoBot *bot = [[SCKDemoBot alloc] init];
        [bot startBotInRoom:kOffice withApiToken:kToken];
        
        CFRunLoopRun();        
    }

    return 0;
}
