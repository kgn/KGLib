//
//  NSString+ISHTTP.m
//  InScopeLib
//
//  Created by David Keegan on 10/1/11.
//

#import <Foundation/Foundation.h>

@interface NSString(ISHTTP)

+ (NSString *)urlEncodedStringForArgs:(NSDictionary *)args;

- (NSString *)stringWithURLEncoding;

@end
