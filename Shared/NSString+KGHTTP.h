//
//  NSString+KGHTTP.m
//  KGLib
//
//  Created by David Keegan on 10/1/11.
//

#import <Foundation/Foundation.h>

@interface NSString(KGHTTP)

+ (NSString *)urlEncodedStringForArgs:(NSDictionary *)args;

- (NSString *)stringWithURLEncoding;

@end