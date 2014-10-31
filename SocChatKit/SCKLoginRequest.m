//
//  SCKLoginRequest.m
//  socchatkitdemo
//
//  Created by Thaddeus Ternes on 10/29/14.
//  Copyright (c) 2014 Thaddeus Ternes. All rights reserved.
//

#import "SCKLoginRequest.h"
#import "SCKDefinitions.h"

@implementation SCKLoginRequest

- (instancetype)init
{
    return [super initWithURL:[NSURL URLWithString:kSococoLoginEndpoint] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:30.0f];
}

- (void)loginWithToken:(NSString *)token forRoom:(NSString *)roomId
{
    NSError *jsonError = nil;
    
    id json = @{ @"token" : token, @"room" : roomId };
    NSData *postData = [NSJSONSerialization dataWithJSONObject:json options:0 error:&jsonError];
    
    if(jsonError == nil)
    {
        [self setHTTPMethod:@"POST"];
        [self setHTTPBody:postData];
        [self setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        NSURLConnection *connection = [NSURLConnection connectionWithRequest:self delegate:self];
        [connection start];
    }
    else
    {
        NSLog(@"failed to serialize login request: %@", jsonError.localizedDescription);
        [self.delegate loginRequest:self failedWithError:jsonError];
    }

}

#pragma mark - 

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"Received connection error during login: %@", error.localizedDescription);
    [self.delegate loginRequest:self failedWithError:error];
}

#pragma mark - NSURLConnectionDataDelegate

// Note: everything needed from login is in the headers, so the body isn't collected
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    
    NSLog(@"Login Headers: %@", httpResponse.allHeaderFields);
    
    NSArray *cookies = [NSHTTPCookie cookiesWithResponseHeaderFields:[httpResponse allHeaderFields] forURL:response.URL];
    [self.delegate loginRequest:self receivedCookies:cookies];
}

@end
