//
//  SCKMessage.m
//  socchatkitdemo
//
//  Created by Thaddeus Ternes on 10/29/14.
//  Copyright (c) 2014 Thaddeus Ternes. All rights reserved.
//

#import "SCKMessage.h"

@implementation SCKMessage

+ (instancetype) messageWithInfo:(NSDictionary *)info
{
    SCKMessage *message = [[SCKMessage alloc] init];
    
    message.senderUserId = info[@"senderID"];
    message.senderDisplayName = info[@"senderDisplayName"];
    message.messageData = info[@"contentData"];

    return message;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@: %@: %@",
            [super description],
            self.senderDisplayName,
            self.messageData];
}

@end
