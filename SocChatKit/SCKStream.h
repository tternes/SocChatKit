//
//  SCKStream.h
//  socchatkitdemo
//
//  Created by Thaddeus Ternes on 10/29/14.
//  Copyright (c) 2014 Thaddeus Ternes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCKMessage.h"

@protocol SCKStreamEventDelegate;

#pragma mark -

@interface SCKStream : NSObject

@property (nonatomic, weak) id<SCKStreamEventDelegate> delegate;

- (void)connectWithToken:(NSString *)apiToken toRoom:(NSString *)roomId;
- (void)disconnect;

- (void)sendMessage:(NSString *)messageText;

@end

#pragma mark - SCKStreamEventDelegate

@protocol SCKStreamEventDelegate <NSObject>

@optional

- (void)stream:(SCKStream *)stream connectedToRoom:(NSString *)roomId;
- (void)streamDisconnected:(SCKStream *)stream;
- (void)stream:(SCKStream *)stream failedToConnectWithError:(NSError *)error;

#pragma mark -
- (void)stream:(SCKStream *)stream receivedMessage:(SCKMessage *)message;
@end