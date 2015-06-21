//
//  UIFont+applicationFont.h
//

#import <UIKit/UIKit.h>

/**
 Extends `UIFont` to provide methods to retrieve a custom application font
 */
@interface UIFont (applicationFont)

+ (UIFont *)lightApplicationFontOfSize:(CGFloat)fontSize;
+ (UIFont *)regularApplicationFontOfSize:(CGFloat)fontSize;
+ (UIFont *)boldApplicationFontOfSize:(CGFloat)fontSize;

@end
