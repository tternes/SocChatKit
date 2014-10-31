//
//  SCKStream.m
//  socchatkitdemo
//
//  Created by Thaddeus Ternes on 10/29/14.
//  Copyright (c) 2014 Thaddeus Ternes. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SCKStream.h"
#import "SCKDefinitions.h"
#import "SCKLoginRequest.h"

#import "DDCometClient.h"
#import "DDCometMessage.h"

@interface SCKStream () <SCKLoginRequestDelegate, DDCometClientDelegate>
@property (nonatomic, strong) SCKLoginRequest *loginRequest;
@property (nonatomic, strong) DDCometClient *client;
@end



@implementation SCKStream

- (void)connectWithToken:(NSString *)apiToken toRoom:(NSString *)roomId
{
    self.loginRequest = [[SCKLoginRequest alloc] init];
    self.loginRequest.delegate = self;
    [self.loginRequest loginWithToken:apiToken forRoom:roomId];
}

- (void)disconnect
{
    [self.client disconnect];
    self.client = nil;
}

- (void)sendMessage:(NSString *)messageText
{
    id data = @{
        @"messageType" : @"Message",
        @"contentData" : messageText,
        @"senderType" : @"API"
    };

    [self.client publishData:data toChannel:kSococoChatStream];
}

#pragma mark - SCKLoginRequestDelegate

- (void)loginRequest:(SCKLoginRequest *)request receivedCookies:(NSArray *)cookies
{
    if(self.loginRequest == request)
    {
        self.client = [[DDCometClient alloc] initWithURL:[NSURL URLWithString:kSococoBayeuxEndpoint]];
        self.client.delegate = self;
        self.client.cookies = cookies;
        [self.client scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [self.client handshake];
        
        self.loginRequest = nil;
    }
}

- (void)loginRequest:(SCKLoginRequest *)request failedWithError:(NSError *)error
{
    if(self.loginRequest == request)
    {
        
        self.loginRequest = nil;
    }
}

#pragma mark - DDCometClientDelegate

- (void)cometClientHandshakeDidSucceed:(DDCometClient *)client
{
    NSLog(@"%s: %@", __PRETTY_FUNCTION__, client);
    
    [client subscribeToChannel:kSococoChatStream target:self selector:@selector(chatMessageReceived:)];
}
- (void)cometClient:(DDCometClient *)client handshakeDidFailWithError:(NSError *)error
{
    NSLog(@"%s: %@", __PRETTY_FUNCTION__, error);
}
- (void)cometClientConnectDidSucceed:(DDCometClient *)client
{
    NSLog(@"%s: %@", __PRETTY_FUNCTION__, client);
}
- (void)cometClient:(DDCometClient *)client connectDidFailWithError:(NSError *)error
{
    NSLog(@"%s: %@", __PRETTY_FUNCTION__, error);
}
- (void)cometClient:(DDCometClient *)client subscriptionDidSucceed:(DDCometSubscription *)subscription
{
    NSLog(@"%s: %@", __PRETTY_FUNCTION__, subscription);
}
- (void)cometClient:(DDCometClient *)client subscription:(DDCometSubscription *)subscription didFailWithError:(NSError *)error
{
    NSLog(@"%s: %@", __PRETTY_FUNCTION__, error);
}

#pragma mark -

- (void)chatMessageReceived:(DDCometMessage *)message
{
    NSLog(@"%s: %@", __PRETTY_FUNCTION__, message);

    if([[message data] isKindOfClass:[NSString class]])
    {
        NSData *jsonData = [(NSString *)[message data] dataUsingEncoding:NSUTF8StringEncoding];

        NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
        [self.delegate stream:self receivedMessage:[SCKMessage messageWithInfo:jsonObject]];
    }
}

@end
