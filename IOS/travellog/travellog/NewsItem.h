//
//  NewsItem.h
//  travellog
//
//  Created by Cullen on 20/6/15.
//  Copyright (c) 2015 Cullen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsItem : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *duration;
@property (nonatomic, strong) NSString *authorProfileUrl;
@property (nonatomic, strong) NSString *location;
@property (nonatomic, strong) NSString *brief;
@property (nonatomic, strong) NSString *coverImageUrl;

@end
