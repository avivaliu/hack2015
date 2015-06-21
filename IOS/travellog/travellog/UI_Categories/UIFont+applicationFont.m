//
//  UIFont+applicationFont.m
//

#import "UIFont+applicationFont.h"

@implementation UIFont (applicationFont)


+ (UIFont *)lightApplicationFontOfSize:(CGFloat)fontSize
{
    return [UIFont fontWithName:@"HelveticaNeue-Light" size:fontSize];
}
+ (UIFont *)regularApplicationFontOfSize:(CGFloat)fontSize
{
    return [UIFont fontWithName:@"HelveticaNeue" size:fontSize];
}
+ (UIFont *)boldApplicationFontOfSize:(CGFloat)fontSize
{
    return [UIFont fontWithName:@"HelveticaNeue-Bold" size:fontSize];
}

@end
