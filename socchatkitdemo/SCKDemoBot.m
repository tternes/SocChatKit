//
//  SCKDemoBot.m
//  socchatkitdemo
//
//  Created by Thaddeus Ternes on 10/29/14.
//  Copyright (c) 2014 Thaddeus Ternes. All rights reserved.
//

#import "SCKDemoBot.h"
#import "SCKStream.h"

@interface SCKDemoBot () <SCKStreamEventDelegate>
@property (nonatomic, strong) SCKStream *stream;
@end

@implementation SCKDemoBot

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        self.stream = [[SCKStream alloc] init];
        self.stream.delegate = self;
    }
    return self;
}

- (void)dealloc
{
    self.stream.delegate = nil;
    self.stream = nil;
}

- (void)startBotInRoom:(NSString *)roomId withApiToken:(NSString *)apiToken
{
    [self.stream connectWithToken:apiToken toRoom:roomId];
}

- (void)stopBot
{
    [self.stream disconnect];
}

#pragma mark - SCKStreamEventDelegate

- (void)stream:(SCKStream *)stream connectedToRoom:(NSString *)roomId
{
    NSLog(@"%s: %@", __PRETTY_FUNCTION__, roomId);
    [stream sendMessage:[NSString stringWithFormat:@"Hello, World! [%@]", [[NSHost currentHost] localizedName]]];
}

- (void)streamDisconnected:(SCKStream *)stream
{
    NSLog(@"%s: %@", __PRETTY_FUNCTION__, stream);
}

- (void)stream:(SCKStream *)stream failedToConnectWithError:(NSError *)error
{
    NSLog(@"%s: %@", __PRETTY_FUNCTION__, error);
}

- (void)stream:(SCKStream *)stream receivedMessage:(SCKMessage *)message
{
    NSLog(@"%s: %@", __PRETTY_FUNCTION__, message);

    if([[message messageData] rangeOfString:@"echo"].location == 0)
        return;
    
    [stream sendMessage:[NSString stringWithFormat:@"echo %@", message.messageData]];
}

@end
