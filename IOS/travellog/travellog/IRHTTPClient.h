//
//  JPHTTPClient.h
//  PushMug
//
//  Created by SUN Cullen on 1/7/13.
//  Copyright (c) 2013 PushMug. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface IRHTTPClient : NSObject

+ (IRHTTPClient *)sharedClient;
+ (void)AFGetRequestWithEndPoint:(NSString *)endpoint;
@end
