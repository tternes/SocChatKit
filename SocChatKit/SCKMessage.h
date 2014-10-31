//
//  SCKMessage.h
//  socchatkitdemo
//
//  Created by Thaddeus Ternes on 10/29/14.
//  Copyright (c) 2014 Thaddeus Ternes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SCKMessage : NSObject
@property (nonatomic, strong) NSString *senderUserId;
@property (nonatomic, strong) NSString *senderDisplayName;
@property (nonatomic, strong) NSString *messageData;

+ (instancetype) messageWithInfo:(NSDictionary *)info;

@end
