//
//  SCKDemoBot.h
//  socchatkitdemo
//
//  Created by Thaddeus Ternes on 10/29/14.
//  Copyright (c) 2014 Thaddeus Ternes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SCKDemoBot : NSObject

- (void)startBotInRoom:(NSString *)roomId withApiToken:(NSString *)apiToken;
- (void)stopBot;

@end
