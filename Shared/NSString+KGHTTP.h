//
//  NSString+KGHTTP.m
//  KGLib
//
//  Created by David Keegan on 10/1/11.
//

#import <Foundation/Foundation.h>

@interface NSString(KGHTTP)

/// Encode a dictionary into a url string.
/// Example: `{name:'David Keegan', age:26}` -> `name=David%20Keegan&age=26`
+ (NSString *)urlEncodedStringForArgs:(NSDictionary *)args;

/// URL encode a string, this encodes more characters than `[NSString stringByAddingPercentEscapesUsingEncoding:]`
- (NSString *)stringWithURLEncoding;

@end
