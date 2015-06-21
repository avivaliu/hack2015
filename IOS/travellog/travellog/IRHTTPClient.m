//
//  IRHTTPClient.m
//  PushMug
//
//  Created by SUN Cullen on 1/7/13.
//  Copyright (c) 2013 PushMug. All rights reserved.
//

#import "IRHTTPClient.h"
#import "Constants.h"

@implementation IRHTTPClient

+ (IRHTTPClient *)sharedClient {
    static IRHTTPClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[IRHTTPClient alloc] init];
    });
    
    return _sharedClient;
}


+ (void)AFGetRequestWithEndPoint:(NSString *)endpoint{
    
    NSString *requestStr = [SeverUrl stringByAppendingString:endpoint];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:requestStr]];
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    [[NSOperationQueue mainQueue] addOperation:op];
}

   

@end
