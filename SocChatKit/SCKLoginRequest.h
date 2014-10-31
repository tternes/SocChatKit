//
//  SCKLoginRequest.h
//  socchatkitdemo
//
//  Created by Thaddeus Ternes on 10/29/14.
//  Copyright (c) 2014 Thaddeus Ternes. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SCKLoginRequestDelegate;
@interface SCKLoginRequest : NSMutableURLRequest

@property (nonatomic, weak) id<SCKLoginRequestDelegate> delegate;

- (void)loginWithToken:(NSString *)token forRoom:(NSString *)roomId;

@end

#pragma mark - 

@protocol SCKLoginRequestDelegate <NSObject>

@required
- (void)loginRequest:(SCKLoginRequest *)request receivedCookies:(NSArray *)cookies;
- (void)loginRequest:(SCKLoginRequest *)request failedWithError:(NSError *)error;

@end